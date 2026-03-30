; -----------------------------------------------------------------------------
; File: Examples/11_Clock_scaling/main.S
; Description: Demonstrates dynamic CPU clock scaling and its effect on peripherals.
;              - Iterates through different CPU clock divisors (1, 2, 4, 8, 16, 32, 64).
;              - Updates the USART baud rate and delay constants dynamically.
;              - Toggles the LED and sends status via a 128-byte ring buffer.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR-Dx/Ex board.
;   Observe the USART output as the clock speed changes; the baud rate remains
;   consistent because it's recalculated after each clock change.
; -----------------------------------------------------------------------------

#include "toggle.S"

; 1. Define a 128-byte Dev-Ring-Buffer for USART0 (regular speed)
HAL_DEVICEBUFFER_DEFINE  TX_DEVBUFFER, 256, USART_ADDR

; -----------------------------------------------------------------------------
; Function: main
; Description: Main application entry point. Initializes hardware and loops through
;              clock prescaler settings.
; Inputs:      None
; Outputs:     Never returns
; -----------------------------------------------------------------------------
FUNC main
    rcall   HAL_BOARD_SETUP                   ; Basic board initialization
    HAL_DEVICEBUFFER_INIT TX_DEVBUFFER        ; Initialize USART TX buffer
    rcall   HAL_PRINT_NEW_LINE
    PRINT_STR "__ CURIOSITY ASSEMBLY __\r\n"
    PRINT_STR "__ CLK: Dynamic CPU clock scaling\r\n"
    sei                                       ; Enable global interrupts

  loop:
    ; 1. Print status and toggle LED
    rcall   print_and_toggle                  ; Print current state to USART
    rcall   HAL_USART_FLUSH_DEVICEBUFFER      ; Send all pending data in buffer

    ; 2. Wait for 1 second (Timing is frequency-aware)
    HAL_DELAY_MS 1000

    ; 3. Load current clock divisor
    ; Clock Prescaler Indices (r22):
    ; 0: /1, 1: /2, 2: /4, 3: /8, 4: /16, 5: /32, 6: /64
    lds     r22, HAL_CLK_MAIN_DIV             ; Load current div to r22
    inc     r22                               ; Increment to next divisor
    cpi     r22, 7                            ; Check if we passed /64   
    brlo    clk_apply                         ; If /64 or lower apply new clock divisor
    ldi     r22, 0                            ; If not, reset to /1

  clk_apply:
    rcall   HAL_CLKCTRL_PRESCALER             ; Apply clock change and update timing
    rcall   HAL_USART_BAUDRATE_UPD            ; Recalculate USART baud for new frequency
    rjmp    loop

ENDF main
