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
#define POLL_TIMER (3600000000) // 1 hour

// the amount of time to wait for pins to go LOW
// if they were open
#define SHORT_WAIT_DELAY 15000 // 15 seconds

// how frequently to poll and report the state
// if entering deep sleep because sensors
// are open longer than SHORT_WAIT_DELAY
#define SHORT_POLL_TIMER (300000000) // 5 minutes

RTC_DATA_ATTR int bootCount = 0;

#define CAUSE_SENSOR_CLOSED 100
#define CAUSE_SHORT_SLEEP 101


#define MAX_MESSAGE_QUEUE 50 // don't really expect more than 10 state updates, but ESP32 has a lot of ram 
int queueIndex = 0;
int reportedQueueCount = 0;
String messageQueue[50];

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
    // do not re-connect if already connected
    if (WiFi.status() == WL_CONNECTED)
        return;

    WiFi.begin(WIFI_SSID, WIFI_PSK);
    while (WiFi.status() != WL_CONNECTED)
    {
        delay(100);
        Serial.println("Connecting to wifi...");
    }
    // connected
}

void queueStatus(int wakeupCause)
{
    // generate the json payload
    String serialized = generatePayload(wakeupCause);
    Serial.print("Sending: ");
    Serial.println(serialized);

    // get a free index and increment it
    noInterrupts();
    int index = queueIndex;
    queueIndex += 1;
    interrupts();

    messageQueue[index] = serialized;
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

void updateStatus()
{
    // update state of sensors
    for (int i = 0; i < NUM_SENSORS; i++)
    {
        sensors[i].state = digitalRead(sensors[i].pin) == HIGH;
    }
}

void sendStateQueue()
{
    noInterrupts();
    int startIndex = reportedQueueCount;
    int endIndex = queueIndex;
    interrupts();

    for (int i = startIndex; i < endIndex; i++)
    {
        String serialized = messageQueue[i];
        // send the contents of the queue
        HTTPClient client;
        client.begin(REPORTING_URL);
        client.addHeader("Content-Type", "application/json");
        int response = client.POST(serialized);
        Serial.print("Got response: ");
        Serial.println(response);

        // update values after they are reported
        noInterrupts();
        reportedQueueCount = i;
        interrupts();
    }
}

void interruptHandler()
{
    updateStatus();

    report();
}

void report()
{
    // blink the led on report
    blink();

    int wakeupCause = esp_sleep_get_wakeup_cause();
    printWakeupCause(wakeupCause);
    printState();

    // enqueue the current state
    // this is so that even if the state goes from closed -> open -> closed
    // in a short amount of time such that the wifi doesn't have time to connect
    // this state transition is not lost, as long as the interrupt had enough time
    queueStatus(wakeupCause);

    // this could take time, so do it after logging state
    connectWifi();

    // send the contents of the message queue once connected
    sendStateQueue();
}

void setup()
{
    bootCount++;

    // read the state of the pins first thing
    for (int i = 0; i < NUM_SENSORS; i++)
    {
        pinMode(sensors[i].pin, INPUT);
        sensors[i].state = digitalRead(sensors[i].pin) == HIGH;

        // attach CHANGE interrupts to each of the pins
        // this way, if the state of the pin changes in the amount of time between
        // now and when the intended reading is reported, this gets reported
        attachInterrupt(digitalPinToInterrupt(sensors[i].pin), interruptHandler, CHANGE);
    }

    Serial.begin(115200);
    report();

    // allow 10 seconds for handlers to update state
    // this prevents a restart if the state changes in a short amount of time
    delay(SHORT_WAIT_DELAY);

    // enter deep sleep with pin interrupts and 1 hour timer
    setupWakeup();
    Serial.println("Entering deep sleep.");
    esp_deep_sleep_start();
}

void loop()
{
    // unused
}
