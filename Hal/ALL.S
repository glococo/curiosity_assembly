; File: Hal/ALL.S
; Description: Master include file for the Hardware Abstraction Layer (HAL).
;              Includes all core macros, math routines, and peripheral drivers.
;
; AVR-GCC _gc register defines
#include "HAL_GC.S"
; Basic assembly macros and register defines
#include "HAL_MACRO.S"
; Instruction Set Extension
#include "HAL_EXTEND.S"
; String and numeric printing functions
#include "HAL_PRINT.S"
; Basic Debug macros
#include "HAL_DEBUG.S"
; Software delay routines
#include "HAL_DELAY.S"

; Arithmetics
#include "MATH_MUL.S"             // Multiplication routines
#include "MATH_DIV.S"             // Division and Modulo routines
#include "MATH_SHIFTS.S"          // Bitwise shift and compare routines

; Buffers
#include "HAL_DEVICEBUFFER.S"     // Ring Buffer (Circular Buffer) library
#include "HAL_DOUBLEBUFFER.S"     // Double-Buffer (Ping-Pong) library

; SOC Drivers
#include "HAL_PORTMUX.S"          // Pin Multiplexing (PORTMUX) helper
#include "HAL_CLKCTRL.S"          // Core Clock and CPU Control (CLKCTRL)
#include "HAL_RTC.S"              // Real-Time Counter (RTC) helper
#include "HAL_WDT.S"              // Watchdog Timer (WDT) helper
#include "HAL_BOD.S"              // Brown-out Detector (BOD) helper
#include "HAL_USART.S"            // USART Serial communication
#include "HAL_I2C.S"              // I2C (TWI) Master communication
//#include "HAL_ADC_EX_define.S"    // ADC EA/EB define constants
#include "HAL_ADC_EX.S"           // Analog-to-Digital Converter (ADC) helper for EA/EB Series
