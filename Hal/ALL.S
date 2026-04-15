; File: Hal/ALL.S
; Description: Master include file for the Hardware Abstraction Layer (HAL).
;              Includes all core macros, math routines, and peripheral drivers.
;

; Basic assembly macros and register defines
#include "HAL_MACRO.S"

; AVR-GCC _gc "group configuration" defines
# define __AVR_GC__ STRINGIFY(avr/_(io,__AVR_DEVICE_NAME__)_gc.S)
# include __AVR_GC__

; Instruction Set Extension
#include "HAL_EXTEND.S"
; String and numeric printing functions
#include "HAL_PRINT.S"
#include "HAL_PRINT_NUM.S"
#include "HAL_PRINT_HEX.S"
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
#include "HAL_PIN.S"              // Port-Pin helper
#include "HAL_PORTMUX.S"          // Pin Multiplexing (PORTMUX) helper
#include "HAL_CLKCTRL.S"          // Core Clock and CPU Control (CLKCTRL)
#include "HAL_SLPCTRL.S"          // Sleep controller
#include "HAL_RTC.S"              // Real-Time Counter (RTC) helper
#include "HAL_WDT.S"              // Watchdog Timer (WDT) helper
#include "HAL_BOD.S"              // Brown-out Detector (BOD) helper
#include "HAL_USART.S"            // USART Serial communication
#include "HAL_I2C.S"              // I2C (TWI) Master communication
#include "HAL_SPI.S"              // SPI Master communication
#include "HAL_TCE.S"              // Timer/Counter Type E (TCE) driver

#ifdef CLKCTRL_MCLKTIMEBASE
  #ifdef ADC0_RESULT0
    #include "HAL_ADC_v2.S"       // Analog-to-Digital Converter (ADC) helper for ADC v2
  #else
    #include "HAL_ADC_v2_lite.S"  // Analog-to-Digital Converter (ADC) helper for ADC v2_lite
  #endif
#else
  #include "HAL_ADC_v1.S"         // Analog-to-Digital Converter (ADC) helper for ADC v1
#endif

