; File: Hal/ALL.S
; Description: Master include file for the Hardware Abstraction Layer (HAL).
;              Includes all core macros, math routines, and peripheral drivers.
;
; Example Usage:
;   #include "Hal/ALL.S"                ; Include this in your main application

; Basic assembly macros and register defines
#include "HAL_MACRO.S"
; Instruction Set Extension
#include "HAL_EXTEND.S"
; Basic Debug macros
#include "HAL_DEBUG.S"
; Multiplication routines
#include "MATH_MUL.S"
; Division and Modulo routines
#include "MATH_DIV.S"
; Bitwise shift routines
#include "MATH_SHIFTS.S"
; Ring Buffer (Circular Buffer) library
#include "HAL_DEVICEBUFFER.S"
; Double-Buffer (Ping-Pong) library
#include "HAL_DOUBLEBUFFER.S"

; Software delay routines
#include "HAL_DELAY.S"
; Real-Time Counter (RTC) helper
#include "HAL_RTC.S"
; String and numeric printing functions
#include "HAL_PRINT.S"

; Core Clock and CPU Control (CLKCTRL)
#include "HAL_CLKCTRL.S"
; USART Serial communication
#include "HAL_USART.S"
; Watchdog Timer (WDT) helper
#include "HAL_WDT.S"
; Brown-out Detector (BOD) helper
#include "HAL_BOD.S"
; Analog-to-Digital Converter (ADC) helper for EA/EB Series
#include "HAL_ADC_EX_define.S"
#include "HAL_ADC_EX.S"
