; File: Hal/HAL_DELAY.S
; Description: Software-based delay routines for millisecond timing.
;

#define _DELAY_MS(ms)   HAL_DELAY_MS ms

; Macro: HAL_DELAY_MS
; Description: Inline macro to perform a millisecond delay.
; Inputs:  milliseconds - Constant value (16-bit)
; Outputs: None
.macro HAL_DELAY_MS milliseconds
  PUSH_MANY r22, r23
    ldi2  r22, \milliseconds            ; Load milliseconds
    rcall HAL_SOFT_DELAY_MS             ; Call the software delay function
  POP_MANY  r23, r22
.endm

; Function: HAL_SOFT_DELAY_MS
; Description: Performs a software-based delay for the specified number of milliseconds.
;              Uses HAL_ONE_MS (calculated in HAL_CORE_PRESCALER) for timing.
; Inputs:  r23:r22 - Number of milliseconds (16-bit)
; Outputs: None
FUNC HAL_SOFT_DELAY_MS
  PUSH_MANY r24, r25
  outer_loop:
    lds2  r24, HAL_ONE_MS_DELAY         ; Load pre-computed ONE_MS_DELAY

  inner_loop:
    sbiw  r24, 1                        ; 2 cycles: Decrement inner counter
    brne  inner_loop                    ; 2/1 cycles: Loop until inner counter is 0

    subi  r22, 1                        ; 1 cycle: Decrement millisecond L
    sbci  r23, 0                        ; 1 cycle: Decrement millisecond H with carry
    brne  outer_loop                    ; 2/1 cycles: Loop until milliseconds reach 0
  POP_MANY r25, r24
ENDF HAL_SOFT_DELAY_MS
