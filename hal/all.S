; File: Hal/ALL.S
; Description: Master include file for the Hardware Abstraction Layer (HAL).
;              Includes all core macros, math routines, and peripheral drivers.
;

; Basic assembly macros and register defines
#include "core/macro.S"
#include "core/family.S"
; Instruction Set Extension
#include "core/extend.S"
; ISR helpers
#include "core/isr.S"
; Software delay routines
#include "core/delay.S"

; String and numeric printing functions
#include "core/print.S"
#include "core/print_num.S"
#include "core/print_hex.S"
; Basic Debug macros
#include "core/debug.S"

; Arithmetics
#include "math/mul.S"             // Multiplication routines
#include "math/div.S"             // Division and Modulo routines
#include "math/shifts.S"          // Bitwise shift and compare routines
#include "math/cast.S"            // Casting macro functions

; Buffers
#include "core/devicebuffer.S"     // Ring Buffer (Circular Buffer) library
#include "core/doublebuffer.S"     // Double-Buffer (Ping-Pong) library

; SOC Drivers
#include "dev/pin.S"              // Port-Pin helper
#include "dev/portmux.S"          // Pin Multiplexing (PORTMUX) helper
#include "dev/clkctrl.S"          // Core Clock and CPU Control (CLKCTRL)
#include "dev/slpctrl.S"          // Sleep controller
#include "dev/rtc.S"              // Real-Time Counter (RTC) helper
#include "dev/wdt.S"              // Watchdog Timer (WDT) helper
#include "dev/bod.S"              // Brown-out Detector (BOD) helper
#include "dev/usart.S"            // USART Serial communication
#include "dev/twi.S"              // I2C (TWI) Master communication
#include "dev/spi.S"              // SPI Master communication
#include "dev/tca.S"              // Timer/Counter Type A (TCA) driver
#include "dev/tce.S"              // Timer/Counter Type E (TCE) driver
#include "dev/vref.S"             // VREF helper
#include "dev/dac.S"              // Digital-to-Analog Converter (DAC) helper
#include "dev/ac.S"               // Analog Comparator (AC) Helper
#include "dev/usb.S"              // USB Device Controller Helper
#include "dev/errctrl.S"          // Error controller on SD Devices

#ifdef CLKCTRL_MCLKTIMEBASE
  #include "dev/adc_v2.S"         // Analog-to-Digital Converter (ADC) helper for ADC v2
#else
  #include "dev/adc_v1.S"         // Analog-to-Digital Converter (ADC) helper for ADC v1
#endif

