#pragma ONCE

struct Sensor
{
    int pin; 
    char* name; // unique name for the sensor on this pin
    bool state; // flag to store the state of this sensor
};