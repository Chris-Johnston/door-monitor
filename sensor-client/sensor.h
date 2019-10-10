#pragma ONCE
#include "string.h"

struct Sensor
{
    int pin;
    String name; // unique name for the sensor on this pin
    bool state; // flag to store the state of this sensor
};