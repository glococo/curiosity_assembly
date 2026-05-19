// my_c_code.c
#include "my_c_code.h"

// This is the function we want to call from Assembly
uint16_t get_blink_interval(uint8_t multiplier) {
    // Simple C logic
    return multiplier * 1000;
}
