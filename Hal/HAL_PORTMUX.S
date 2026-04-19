; File: Hal/HAL_PORTMUX.S
; Description: Helper macro for configuring pin multiplexing (PORTMUX) on modern AVR-Dx/Ex families.
;              Provides a simple interface to route peripheral signals to alternative pins.
;
#define _PORTMUX( dev, alt, reg )    HAL_PORTMUX _(_(_(_(PORTMUX_,dev),_),alt),_gc), reg

; Preprocessor Macro: HAL_PORTMUX
; Description: Directly sets a PORTMUX register with a given value.
.macro HAL_PORTMUX val, reg
    ldi r16, \val
    sts \reg, r16
.endm

/*
; Preprocessor Macro: HAL_PORTMUX
; Description: Bridges naming conventions to the assembler macro.
;              Token-pasting happens here, and then the preprocessor expands
;              the resulting constants before the assembler sees the macro call.
#define _PORTMUX_ROUTEA( device, id, alternate ) \
    HAL_PORTMUX_ASM PORTMUX_##device##id##_##alternate##_gc, PORTMUX_##device##ROUTEA

#define _PORTMUX_ROUTEB( device, id, alternate ) \
    HAL_PORTMUX_ASM PORTMUX_##device##id##_##alternate##_gc, PORTMUX_##device##ROUTEB

; Preprocessor Macro: HAL_PORTMUX_REG
; Description: Directly sets a PORTMUX register with a given value/bitmask.
; #define _PORTMUX_REG(reg_addr, value)    HAL_PORTMUX_ASM value, reg_addr

; Assembler Macro: HAL_PORTMUX
; Description: Internal macro to generate multiple lines.
;              This is called by the preprocessor macro to ensure correct line breaks.

*/
