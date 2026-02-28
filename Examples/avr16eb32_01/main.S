; File: main.S
; Description: Blinks the BOARD LED and send a MSG in UART0 at 1 Hz, while CPU scaling between 20, 10 and 5 mhz
; Target: AVR16EB32 CURIOSITY NANO eval board
#include "../../Boards/AVR16EB32_Curiosity_Nano.S"

#define  REG_HELLO_OR_HOLA  r10
; #define  LED_R              PIN6_bm
; #define  LED_G              PIN7_bm
; #define  LED_B              PIN0_bm
; #include "setup.S"
; #include "soft_delay_ms.S"
#include "toggle.S"

DEFUN main                    ; ✅ Main Program
  main:
    ; ldi   r16, (LED_R | LED_G | LED_B)    ; Enable LED_RGB output
    ; sts   PORTD_DIRSET, r16

    rcall BOARD_SETUP_DEFAULT
    sei

  loop:
    ldi r16, 0                ; Clock/1 (PEN=0, PDIV = 0)
    rcall HAL_CPU_SPEED
    rcall HAL_USART_UPDATE_BAUDRATE
    rcall toggle
    ldi   r24, lo8( 65530 )
    ldi   r25, hi8( 65530 )
    ldi   r22, 3
    ldi   r23, 0
    rcall MATH_DIV_16_16
    mov   r25, r23
    mov   r24, r22

    rcall Print_UInt16
    OS_DELAY_MS 1000

    ldi r16, 1                ; Clock/2 (PEN=1, PDIV = 0)
    rcall HAL_CPU_SPEED
    rcall HAL_USART_UPDATE_BAUDRATE
    rcall toggle
    OS_DELAY_MS 1000

    ldi r16, 2                ; Clock/4 (PEN=1, PDIV = 1)
    rcall HAL_CPU_SPEED
    rcall HAL_USART_UPDATE_BAUDRATE
    rcall toggle
    OS_DELAY_MS 1000

    ldi r16, 3                ; Clock/8 (PEN=1, PDIV = 2)
    rcall HAL_CPU_SPEED
    rcall HAL_USART_UPDATE_BAUDRATE
    rcall toggle
    OS_DELAY_MS 1000

    ldi r16, 4                ; Clock/16 (PEN=1, PDIV = 3)
    rcall HAL_CPU_SPEED
    rcall HAL_USART_UPDATE_BAUDRATE
    rcall toggle
    OS_DELAY_MS 1000

    ldi r16, 5                ; Clock/32 (PEN=1, PDIV = 4)
    rcall HAL_CPU_SPEED
    rcall HAL_USART_UPDATE_BAUDRATE
    rcall toggle
    OS_DELAY_MS 1000

    ldi r16, 6                ; Clock/64 (PEN=1, PDIV = 5)
    rcall HAL_CPU_SPEED
    rcall HAL_USART_UPDATE_BAUDRATE
    rcall toggle
    OS_DELAY_MS 1000

    rjmp  loop

ENDF main

DEFUN PORTF_PORT_vect         ; ✅ Button Interrupt
  PORTF_PORT_vect:            ; PUSH_BUTTON toggle LED and UART message
  ISR_START r18

    ldi     r18, 1
    eor     REG_HELLO_OR_HOLA, r18
    ldi     r18, 0x40
    sts     PORTF_INTFLAGS, r18

  ISR_END r18
ENDF PORTF_PORT_vect
