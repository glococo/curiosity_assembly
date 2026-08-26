#ifndef MY_C_CODE_H
#define MY_C_CODE_H

#ifdef __ASSEMBLER__
    // Assembly-specific declarations
    .extern get_blink_interval
#else
    // C-specific declarations
    #include <stdint.h>
    uint16_t get_blink_interval(uint8_t multiplier);
#endif

#endif /* MY_C_CODE_H */
