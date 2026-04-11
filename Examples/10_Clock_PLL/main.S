; -----------------------------------------------------------------------------
; File: Examples/10_Clock_PLL/main.S
; Description: Demonstrates PLL (Phase-Locked Loop) configuration and lock.
;              - Configures OSCHF to 16 MHz (required for PLL).
;              - Enables PLL with a multiplier to reach high frequencies.
;              - Switches main clock to PLL and updates system timings.
;              - Toggles the board LED and sends a status string via USART.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board (e.g., AVR-DU).
;   The board will run at a high clock frequency (160 MHz PLL / 8 = 20 MHz CPU).
;   The LED will blink and a message will be sent via USART every second.
; -----------------------------------------------------------------------------

#define CORE_CLOCK_PLL_KHZ      160000
#ifndef CLKCTRL_CLKSEL_PLL_gc
  .error "This core do not support Main Clock Source from PLL"
  .abort
#endif

FUNC main
    rcall   HAL_BOARD_SETUP                   ; Basic board and USART initialization
    _DEVBUFFER(RX_DEVBUFFER, 64, USART_ADDR)  ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __ \r\n")
    _STR("__ Source clock from PLL\r\n")$ _STR_FLUSH()

    ldi     r22, 3                            ; Slowdown CPU before switching to 160mhz
    rcall   HAL_CLKCTRL_PRESCALER             ; to avoid CPU going beyond 20mhz
    rcall   HAL_USART_BAUDRATE_UPD

    ldi     r22, (CLKCTRL_SOURCEDIV_DIV1_gc | CLKCTRL_MULFAC_8X_gc)
    rcall   HAL_CLKCTRL_PLL_SET               ; Setting PLL to 160 Mhz

    ldi     r22, CLKCTRL_CLKSEL_PLL_gc        ; Setting PLL as Main Source Clock
    rcall   HAL_CLKCTRL_MAIN_SELECT

    ldi4    r22, CORE_CLOCK_PLL_KHZ
    sts4    HAL_CLK_MAIN_KHZ, r22

    ldi     r22, 3
    rcall   HAL_CLKCTRL_PRESCALER             ; Rerun function CPU/DIV to 20mhz to update ONE_MS
    rcall   HAL_USART_BAUDRATE_UPD            ; and update baudrate

  loop:
    _PIN_TGL(BOARD_LED_PORT, BOARD_LED_PIN)
    _STR("Hello World, PLL @ 160mhz !\r\n")$ _STR_FLUSH()
    _DELAY_MS(2000)                           ; Wait 1 second (overwrites r22, r23)
    rjmp    loop                              ; Repeat indefinitely

ENDF main
