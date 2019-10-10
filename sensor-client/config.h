#pragma ONCE
#include "sensor.h"

#define WIFI_SSID "ssid"
#define WIFI_PSK  "psk"

#define REPORTING_URL "http://10.1.1.122:8080/"

// define the sensors
Sensor sensors[] = {
    // pin must be one of 0,2,4,12-15,25-27,32-39
    { 32, "LOCK" },
    { 33, "DOOR" }
};

#define NUM_SENSORS 2