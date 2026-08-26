; -----------------------------------------------------------------------------
; File: Examples/11_Clock_scaling/main.S
; Description: Demonstrates dynamic CPU clock scaling and its effect on peripherals.
;              - Iterates through different CPU clock divisors (1, 2, 4, 8, 16, 32, 64).
;              - Updates the USART baud rate and delay constants dynamically.
;              - Toggles the LED and sends status via a 128-byte ring buffer.
; -----------------------------------------------------------------------------

#include "toggle.S"

; -----------------------------------------------------------------------------
; Function: main
; Description: Main application entry point. Initializes hardware and loops through
;              clock prescaler settings.
; -----------------------------------------------------------------------------
FUNC main
    call   HAL_BOARD_SETUP                       ; Basic board initialization
    _DEVBUFFER(TX_DEVBUFFER, 128, USART_ADDR)     ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __\r\n")
    _STR("__ CLK: Dynamic CPU clock scaling\r\n")
    sei                                           ; Enable global interrupts

  loop:
    call   print_and_toggle                  ; Print current state to USART
    _DELAY_MS(2000)                           ; Wait for 2sec (Timing is frequency-aware)

    ; 3. Load current clock divisor
    ; Clock Prescaler Indices (r22):
    ; 0: /1, 1: /2, 2: /4, 3: /8, 4: /16, 5: /32, 6: /64
    lds     r22, HAL_CLK_MAIN_DIV             ; Load current div to r22
    inc     r22                               ; Increment to next divisor
    cpi     r22, 7                            ; Check if we passed /64
    brlo    clk_apply                         ; If /64 or lower apply new clock divisor
    ldi     r22, 0                            ; If not, reset to /1

  clk_apply:
    call   HAL_CLKCTRL_PRESCALER             ; Apply clock change and update timing
    call   HAL_USART_BAUDRATE_UPD            ; Recalculate USART baud for new frequency
    jmp    loop

ENDF main
