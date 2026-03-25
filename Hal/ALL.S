; File: Hal/ALL.S
; Description: Master include file for the Hardware Abstraction Layer (HAL).
;              Includes all core macros, math routines, and peripheral drivers.
;
; Example Usage:
;   #include "Hal/ALL.S"                ; Include this in your main application

; Basic assembly macros and register defines
#include "HAL_MACRO.S"
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
