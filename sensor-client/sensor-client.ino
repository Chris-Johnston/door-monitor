#include "Esp.h"
#include "WiFi.h"
#include "HTTPClient.h"
#include "config.h"
#include <ArduinoJson.h>

#define LED_BUILTIN 2

// TODO see if I can report voltage to indicate battery health
// might need to hook up to ADC

// how frequently to report the state, even if the pin
// interrupt has not fired
#define POLL_TIMER (360000000) // 1 hour

RTC_DATA_ATTR int bootCount = 0;

#define CAUSE_SENSOR_CLOSED 100

void blink()
{
    pinMode(LED_BUILTIN, OUTPUT);
    for (int i = 0; i < 2; i++)
    {
        digitalWrite(LED_BUILTIN, HIGH);
        delay(100);
        digitalWrite(LED_BUILTIN, LOW);
        delay(100);
    }
}

void printWakeupCause(int wakeupCause)
{
    Serial.print("Restart due to ");
    switch (wakeupCause)
    {
        case ESP_SLEEP_WAKEUP_EXT1:
            Serial.println("pin state");
            break;
        case ESP_SLEEP_WAKEUP_TIMER:
            Serial.println("timer");
            break;
        default:
            Serial.println("power up");
            break;
    }
}

void printState()
{
    for (auto sensor : sensors)
    {
        Serial.print("Pin ");
        Serial.print(sensor.pin);
        Serial.print(" : ");
        Serial.println(sensor.state);
    }
}

void setupWakeup()
{
    // timer wakeup
    int state = esp_sleep_enable_timer_wakeup(POLL_TIMER);
    if (state != ESP_OK)
    {
        Serial.println("Got error when setting timer wakeup.");
    }

    // pin wakeup
    uint64_t mask = 0;
    for (auto sensor : sensors)
    {
        mask |= ((unsigned long long)1 << sensor.pin);
    }
    
    state = esp_sleep_enable_ext1_wakeup(mask, ESP_EXT1_WAKEUP_ANY_HIGH);
    if (state != ESP_OK)
    {
        Serial.println("Got error when setting ext1 wakeup.");
    }
}

void connectWifi()
{
    WiFi.begin(WIFI_SSID, WIFI_PSK);
    while (WiFi.status() != WL_CONNECTED)
    {
        delay(500);
        Serial.println("Connecting to wifi...");
    }
    // connected
}

void reportStatus(String payload)
{
    HTTPClient client;
    client.begin(REPORTING_URL);
    client.addHeader("Content-Type", "application/json");
    int response = client.POST(payload);
    Serial.print("Got response: ");
    Serial.println(response);
}

bool waitLow()
{
    bool requiredWait = false;
    bool anyHigh = false;
    for (auto sensor : sensors)
    {
        anyHigh |= digitalRead(sensor.pin) == HIGH;
    }

    requiredWait = anyHigh;
    while (anyHigh) // block while any pins are HIGh
    {
        anyHigh = false;
        Serial.println("Waiting for LOW state.");
        delay(5000);
        for (auto sensor : sensors)
        {
            anyHigh |= digitalRead(sensor.pin) == HIGH;
        }
    }
    return requiredWait;
}

String generatePayload(int wakeupCause)
{
    StaticJsonDocument<400> doc; // TODO - determine a good default for staticjsondocument
    doc["cause"] = wakeupCause;
    JsonArray sensorsArr = doc.createNestedArray("sensors");
    for (auto sensor : sensors)
    {
        auto nestedObj = sensorsArr.createNestedObject();
        nestedObj["name"] = sensor.name;
        nestedObj["state"] = sensor.state;
    }
    String serialized;
    serializeJson(doc, serialized);
    return serialized;
}

void setup()
{
    // read the state of the pins first thing
    for (int i = 0; i < NUM_SENSORS; i++)
    {
        pinMode(sensors[i].pin, INPUT);
        sensors[i].state = digitalRead(sensors[i].pin) == HIGH;
    }

    bootCount++;
    Serial.begin(115200);

    // blink the led on boot
    blink();

    int wakeupCause = esp_sleep_get_wakeup_cause();
    printWakeupCause(wakeupCause);
    printState();

    // generate the json payload
    String serialized = generatePayload(wakeupCause);
    Serial.print("Sending: ");
    Serial.println(serialized);
    connectWifi();
    reportStatus(serialized);

    // wait for all sensors to return to LOW state
    bool anyHigh = waitLow();

    // if any pins were high and required waiting, log again when they
    // are closed
    if (anyHigh)
    {
        Serial.println("Pins were high, logging again now that pins are LOW.");
        // change the wakeup cause for the matching close message
        wakeupCause = CAUSE_SENSOR_CLOSED;

        // log when the sensors go low
        // read state again
        for (int i = 0; i < NUM_SENSORS; i++)
        {
            sensors[i].state = digitalRead(sensors[i].pin) == HIGH;
        }
        Serial.println("Reporting:");
        serialized = generatePayload(wakeupCause);
        Serial.println(serialized);
        reportStatus(serialized);
    }

    setupWakeup();
    Serial.println("Entering deep sleep.");
    esp_deep_sleep_start();
}

void loop()
{
    // unused
}
