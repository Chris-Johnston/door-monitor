#include "Esp.h"
#include "WiFi.h"
#include "HTTPClient.h"
#include "config.h"

#define LED_BUILTIN 2

// how frequently to report the state, even if the pin
// interrupt has not fired
#define POLL_TIMER (60 * 60 * 1000000) // 1 hour


RTC_DATA_ATTR int bootCount = 0;

// ESP_EXT1_WAKEUP_ANY_HIGH
// wake up when any are high, need to ensure wiring works with this

void setup()
{
    bootCount++;
    
    blonk();

    Serial.begin(115200);
    Serial.println("starting");

    for (auto sensor : sensors)
    {
        pinMode(sensor.pin, INPUT);
        Serial.print("State: ");
        Serial.println(digitalRead(sensor.pin));
    }

    
    Serial.println("Starting sensor client.");
    Serial.println(bootCount);

    connectWifi();

    auto wakeup_reason = esp_sleep_get_wakeup_cause();

  switch(wakeup_reason){
    case ESP_SLEEP_WAKEUP_EXT0 : Serial.println("Wakeup caused by external signal using RTC_IO"); break;
    case ESP_SLEEP_WAKEUP_EXT1 : Serial.println("Wakeup caused by external signal using RTC_CNTL"); break;
    case ESP_SLEEP_WAKEUP_TIMER : Serial.println("Wakeup caused by timer"); break;
    case ESP_SLEEP_WAKEUP_TOUCHPAD : Serial.println("Wakeup caused by touchpad"); break;
    case ESP_SLEEP_WAKEUP_ULP : Serial.println("Wakeup caused by ULP program"); break;
    default : Serial.printf("Wakeup was not caused by deep sleep: %d\n",wakeup_reason); break;
  }

    reportBootup();

    pinMode(LED_BUILTIN, OUTPUT);
    pinMode(32, INPUT);

    // should deep sleep for a minute
    // auto mask = (1 << 32) | (1 << 39);
    // uint64_t mask = (1 << 32);
    auto response = esp_sleep_enable_ext1_wakeup(0x100000000, ESP_EXT1_WAKEUP_ANY_HIGH);
    Serial.println(response);

    esp_sleep_enable_timer_wakeup(10 * 1000000);
}

void blonk()
{
    for (int i = 0; i < 5; i++)
    {
        digitalWrite(LED_BUILTIN, HIGH);
        delay(100);
        digitalWrite(LED_BUILTIN, LOW);
        delay(100);
    }
}

void loop()
{
    Serial.println("UP");
    blonk();
    
    Serial.println("Entering deep sleep.");
    esp_deep_sleep_start();
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

void reportBootup()
{
    HTTPClient client;
    client.begin(BOOTUP_URL);
    int response = client.POST("this is the payload");
    Serial.println("Got response");
    Serial.println(response);
}