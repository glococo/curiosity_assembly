; File: Examples/12_Clock_from_PLL/main.S
; Description: Demonstrates PLL (Phase-Locked Loop) configuration and lock.
;              - Configures OSCHF to 16 MHz (required for PLL).
;              - Enables PLL with a multiplier.
;              - Waits for PLL lock.
;              - (Optional) Switches main clock to PLL if supported (AVR DU).
;              - Toggles the board LED and sends the selected string every 1 second.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.

; Function: main
; Description: Application entry point. Initializes hardware, USART and PLL,
;              then enters a periodic loop to toggle the LED.
#define CORE_CLOCK_PLL_KHZ      160000

.section    .progmem.rodata
ASCIZ HELLO "Hello World, Main source clock PLL !\r\n"

FUNC main
    rcall   HAL_BOARD_SETUP                             ; Basic board and USART initialization

    ldi     r22, 3                                      ; Slowdown CPU previously before switching to 160mhz
    rcall   HAL_CLKCTRL_PRESCALER                       ;  to avoid CPU going beyond 20mhz
    rcall   HAL_USART_BAUDRATE_UPD

    ldi     r22, (HAL_CLKCTRL_PLL_DIV_0 | HAL_CLKCTRL_PLL_MUL_8 )
    rcall   HAL_CLKCTRL_PLL_SET                         ; Setting PLL to 160 Mhz

    ldi     r22, HAL_CLKCTRL_SRC_PLL                    ; Setting PLL as Main Source Clock
    rcall   HAL_CLKCTRL_MAIN_SELECT

    ldi4    r22, CORE_CLOCK_PLL_KHZ
    sts4    HAL_CLK_MAIN_KHZ, r22

    ldi     r22, 3
    rcall   HAL_CLKCTRL_PRESCALER                       ; Rerun function CPU/DIV to 20mhz to update ONE_MS
    rcall   HAL_USART_BAUDRATE_UPD                      ; and update baudrate


    ldiw    YL, USART_ADDR                      ; Set Y to point to USART0 for HAL_USART_SEND_LENGTH
    ldiw    ZL, MAPPED_PROGMEM_START + HELLO    ; Load HELLO
    ldi     r22, LENGTH( HELLO )                ; Load string length
    ldi     r21, BOARD_LED_PIN                  ; Load LED pin mask

  loop:
    ldi     r21, BOARD_LED_PIN              ; Load LED pin mask
    sts     _(BOARD_LED_PORT,_OUTTGL), r21  ; Toggle LED via hardware register

    ldi     r22, LENGTH( HELLO )            ; Load string length
    rcall   HAL_USART_SEND_LENGTH           ; Send string: r22=len, Z=data, Y=uart

    HAL_DELAY_MS 1000                       ; Wait 1 second (overwrite r22, r23)
    rjmp    loop                            ; Repeat indefinitely

ENDF main

