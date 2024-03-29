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
#define POLL_TIMER (6 * 3600000000) // 6 * 1 hour

// the amount of time to wait for interrupts before going low
#define SHORT_WAIT_DELAY (5000 * 1000) // 15 seconds

RTC_DATA_ATTR int bootCount = 0;
RTC_DATA_ATTR int shortSleepCounter = 0;

#define SHORT_SLEEP_TIMES 11
unsigned long shortSleepTimes[] = 
{
    // 1 minute
    1 * 60 * 1000 * 1000,
    // 1 minute
    1 * 60 * 1000 * 1000,
    // 2 minutes
    2 * 60 * 1000 * 1000,
    // 3 minutes
    3 * 60 * 1000 * 1000,
    // 5 minutes
    5 * 60 * 1000 * 1000,
    // 8 minutes
    8 * 60 * 1000 * 1000,
    // 13 minutes
    13 * 60 * 1000 * 1000,
    // 21 minutes
    21 * 60 * 1000 * 1000,
    // 34 minutes
    34 * 60 * 1000 * 1000,
    // 55 minutes
    55 * 60 * 1000 * 1000,
    // 1 hour
    60 * 60 * 1000 * 1000,
};

long lastMicros = 0;
long waitMicros = 0;
#define DEBOUNCE_TIME (200 * 1000) // 200 ms

#define CAUSE_SENSOR_CLOSED 100
#define CAUSE_INTERRUPT 101

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
        case CAUSE_INTERRUPT:
            Serial.println("Interrupt");
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

// set up the deep sleep wakeup handlers
void setupWakeup()
{
    // if all pins are LOW, so all of the pin handlers can be used, then
    // the sleep timer can be very long, up to hours
    // but if one or more pins are HIGH, these handlers cannot be used,
    // so the sleep timer should be short, and grow exponentially from 1 minute to 1 hour
    bool anyHigh = false;
    for (auto sensor : sensors)
    {
        anyHigh |= sensor.state;
    }

    int state;

    // timer wakeup
    if (anyHigh)
    {
        // use short timer
        shortSleepCounter = shortSleepCounter + 1;
        if (shortSleepCounter > SHORT_SLEEP_TIMES)
        {
            shortSleepCounter = SHORT_SLEEP_TIMES;
        }

        unsigned long time = shortSleepTimes[shortSleepCounter - 1];
        Serial.print("Short sleep for time: ");
        Serial.println(time);
        state = esp_sleep_enable_timer_wakeup(time);
    }
    else
    {
        // reset the sleep counter
        shortSleepCounter = 0;
        // use long timer
        state = esp_sleep_enable_timer_wakeup(POLL_TIMER);
    }

    if (state != ESP_OK)
    {
        Serial.println("Got error when setting timer wakeup.");
    }

    // pin wakeup
    uint64_t mask = 0;
    for (auto sensor : sensors)
    {
        // only set the mask if the pin is LOW
        if (!sensor.state)
        {
            mask |= ((unsigned long long)1 << sensor.pin);
        }
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
    // log the progress of sending the state queue
    Serial.print("Sending the contents of the state message queue: ");
    Serial.print(reportedQueueCount);
    Serial.print("/");
    Serial.println(queueIndex);

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
        Serial.print("Got response code: ");
        Serial.println(response);

        // update values after they are reported
        noInterrupts();
        reportedQueueCount = i + 1;
        interrupts();
    }
}

void IRAM_ATTR interruptHandler()
{
    // handle debounce
    if ((long)(micros() - lastMicros) >= DEBOUNCE_TIME)
    {
        lastMicros = micros();
        // need to handle debouncing
        updateStatus();

        report(CAUSE_INTERRUPT);
    }
}

void report(int wakeupCause)
{
    // update the timer for how long to wait before deep sleep
    waitMicros = micros();

    printState();

    // enqueue the current state
    // this is so that even if the state goes from closed -> open -> closed
    // in a short amount of time such that the wifi doesn't have time to connect
    // this state transition is not lost, as long as the interrupt had enough time
    queueStatus(wakeupCause);
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

    int wakeupCause = esp_sleep_get_wakeup_cause();
    printWakeupCause(wakeupCause);
    
    report(wakeupCause);

    // blink the led on boot
    blink();

    // this could take time, so do it after logging state
    connectWifi();

    // send the contents of the message queue once connected
    sendStateQueue();

    // wait SHORT_WAIT_DELAY for messages to be sent
    // if any interrupts happen, this timer is reset
    while (((long)micros() - waitMicros) <= SHORT_WAIT_DELAY)
    {
        // this delay allows time for the interrupts to be hit
        delay(100);

        // send state queue if there are any updates
        // this prevents restart for changes in a short amount of time
        sendStateQueue();
    }

    // still need to have a way of more frequent deep sleep for pins that are high

    // enter deep sleep with pin interrupts and 1 hour timer
    setupWakeup();
    Serial.println("Entering deep sleep.");
    esp_deep_sleep_start();
}

void loop()
{
    // unused
}
