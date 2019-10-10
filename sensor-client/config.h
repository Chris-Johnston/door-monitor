#pragma ONCE
#include "sensor.h"

#define WIFI_SSID "haha oops"
#define WIFI_PSK  "i almost committed and pushed my password"

#define BOOTUP_URL "http://10.1.1.122:8080/"

// define the sensors
Sensor sensors[] = {
    // pin must be one of 0,2,4,12-15,25-27,32-39
    { 32, "LOCK" },
    { 33, "DOOR" }
};