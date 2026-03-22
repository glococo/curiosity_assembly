; File: Examples/Math_tests/main.S
; Description: Comprehensive test suite for the AVR-DEV math library.
;              - Tests 8, 16, 32, and 64-bit multiplication.
;              - Tests Multiply-Accumulate (MAC) operations.
;              - Tests signed and unsigned variants.
;              - Outputs results via USART.
;
; Example Usage:
;   This is a standalone test suite. Compile and flash to a supported AVR board.
;   Connect via USART to see the test results and verify math library correctness.

.section        .progmem.rodata
STR_START:      .asciz "    AVR-DEV Math Library Test Suite"
STR_HLINE:      .asciz "\r\n----------------------------------------\r\n"

; Define a 256-byte Dev-Ring-Buffer for USART0 (regular speed)
HAL_DEVICEBUFFER_DEFINE  USART0_TX_DEVBUFFER, 256, USART0_ADDR

; Function: main
; Description: Application entry point. Executes a series of math tests
;              and prints the results to USART.
; Inputs:  None
; Outputs: Never returns
FUNC main
    rcall   HAL_BOARD_SETUP             ; Basic board initialization
    HAL_DEVICEBUFFER_INIT USART0_TX_DEVBUFFER ; Initialize USART TX buffer

    ; Set Z to point to the device buffer for all PRINT functions
    ldi     ZL, lo8( USART0_TX_DEVBUFFER )
    ldi     ZH, hi8( USART0_TX_DEVBUFFER )

    PRINT_STR_X STR_HLINE
    PRINT_STR_X STR_START               ; Welcome message
    PRINT_STR_X STR_HLINE

    ; --- 8-bit Hardware MUL Tests ---
    PRINT_STR "\r\nTesting hw mul 8-bit Operation:\r\n"
    PRINT_STR "  MUL 8x8: 246 * 251 = "
    ldi     r22, 246                    ; Load A
    ldi     r18, 251                    ; Load B
    mul     r22, r18                    ; Hardware multiply
    movw    r22, r0                     ; Move result to r23:r22
    rcall   HAL_PRINT_UINT16_REG        ; Print 16-bit result
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MULS 8x8: 89 * -102 = "
    ldi     r22, 89                     ; Load signed A
    ldi     r18, -102                   ; Load signed B
    muls    r22, r18                    ; Signed hardware multiply
    movw    r22, r0                     ; Move result
    rcall   HAL_PRINT_INT16_REG         ; Print signed result
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MULSU 8x8: 189 * -102 = "
    ldi     r22, 189                    ; Load unsigned A
    ldi     r18, -102                   ; Load signed B
    mulsu   r18, r22                    ; Signed * Unsigned hardware multiply
    movw    r22, r0                     ; Move result
    rcall   HAL_PRINT_INT16_REG         ; Print signed result
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    ; --- 16-bit Library Tests ---
    PRINT_STR "\r\nMATH MUL 16-bit Operations:\r\n"
    PRINT_STR "  MUL 16x16_16: 123 * 456 = "
    ldi     r22, lo8(123)               ; Load 16-bit A
    ldi     r23, hi8(123)
    ldi     r18, lo8(456)               ; Load 16-bit B
    ldi     r19, hi8(456)
    rcall   MATH_MUL_16_16              ; 16x16 -> 16-bit
    rcall   HAL_PRINT_UINT16_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MUL 16x16_32: 1623 * 4256 = "
    ldi     r22, lo8(1623)
    ldi     r23, hi8(1623)
    ldi     r18, lo8(4256)
    ldi     r19, hi8(4256)
    rcall   MATH_MUL_16_32              ; 16x16 -> 32-bit
    rcall   HAL_PRINT_UINT32_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MAC 16x16_16: 1000 + (10 * 20) = "
    ldi     r22, lo8(1000)              ; Load Accumulator
    ldi     r23, hi8(1000)
    ldi     r18, lo8(10)                ; Load A
    ldi     r19, hi8(10)
    ldi     r20, lo8(20)                ; Load B
    ldi     r21, hi8(20)
    rcall   MATH_MAC_16_16              ; Accum += A * B
    rcall   HAL_PRINT_UINT16_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MAC 16x16_32: 1234 + (810 * 1120) = "
    ldi     r22, lo8(1234)              ; Load 32-bit Accumulator
    ldi     r23, hi8(1234)
    clr     r24
    clr     r25
    ldi     r18, lo8(810)               ; Load 16-bit A
    ldi     r19, hi8(810)
    ldi     r20, lo8(1120)              ; Load 16-bit B
    ldi     r21, hi8(1120)
    rcall   MATH_MAC_16_32              ; 32-bit Accum += 16 * 16
    rcall   HAL_PRINT_UINT32_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MUL_S 16_32: -100 * 500 = "
    ldi     r22, lo8(-100)              ; Load signed 16-bit A
    ldi     r23, hi8(-100)
    ldi     r18, lo8(500)               ; Load 16-bit B
    ldi     r19, hi8(500)
    rcall   MATH_MUL_S_16_32            ; Signed 16x16 -> 32-bit
    rcall   HAL_PRINT_INT32_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    ; --- 32-bit Library Tests ---
    PRINT_STR "\r\nMATH_MUL 32-bit Operations:\r\n"
    PRINT_STR "  MUL 32x32_32: 10000 * 20000 = "
    ldi     r22, lo8(10000)             ; Load 32-bit A
    ldi     r23, hi8(10000)
    clr     r24
    clr     r25
    ldi     r18, lo8(20000)             ; Load 32-bit B
    ldi     r19, hi8(20000)
    clr     r20
    clr     r21
    rcall   MATH_MUL_32_32              ; 32x32 -> 32-bit
    rcall   HAL_PRINT_UINT32_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MUL 32x32_64: 24231033 * 9827352 = "
    ldi     r22, lo8(24231033)          ; Load 32-bit A
    ldi     r23, hi8(24231033)
    ldi     r24, hlo8(24231033)
    ldi     r25, hhi8(24231033)
    ldi     r18, lo8(9827352)           ; Load 32-bit B
    ldi     r19, hi8(9827352)
    ldi     r20, hlo8(9827352)
    ldi     r21, hhi8(9827352)
    rcall   MATH_MUL_32_64              ; 32x32 -> 64-bit
    rcall   HAL_PRINT_UINT64_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MAC 32_32: 515 + (105 * 92) = "
    ldi     r22, lo8(515)               ; Load 32-bit Accumulator
    ldi     r23, hi8(515)
    clr     r24
    clr     r25
    ldi     r18, lo8(105)               ; Load 32-bit A
    ldi     r19, hi8(105)
    clr     r20
    clr     r21
    ldi     r26, lo8(92)                ; Load 32-bit B
    ldi     r27, hi8(92)
    clr     r28
    clr     r29
    rcall   MATH_MAC_32_32              ; 32-bit Accum += 32 * 32
    rcall   HAL_PRINT_UINT32_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MUL_S 32_64: -1124 * 1234567 = "
    ; A = -1124 (signed 32-bit)
    ldi     r22, lo8(-1124)
    ldi     r23, hi8(-1124)
    ldi     r24, 0xFF
    ldi     r25, 0xFF
    ; B = 1234567 (32-bit)
    ldi     r18, lo8(1234567)
    ldi     r19, hi8(1234567)
    ldi     r20, hlo8(1234567)
    ldi     r21, hhi8(1234567)
    rcall   MATH_MUL_S_32_64            ; Signed 32x32 -> 64-bit
    rcall   HAL_PRINT_INT64_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    ; --- 64-bit Library Tests ---
    PRINT_STR "\r\nMATH_MUL 64-bit Operations:\r\n"
    PRINT_STR "  MUL 64_64: 12345678 * 89 = "
    ; B = 89 (64-bit)
    ldi     r16, 89
    mov     r10, r16
    CLR_BLOCK r11, 7                    ; Clear r17:r11
    ; A = 12345678 (64-bit)
    ldi     r18, lo8(12345678)
    ldi     r19, hi8(12345678)
    ldi     r20, hlo8(12345678)
    ldi     r21, hhi8(12345678)
    CLR_BLOCK r22, 4                    ; Clear r25:r22
    rcall   MATH_MUL_64_64              ; 64x64 -> 64-bit
    rcall   HAL_PRINT_UINT64_REG
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR_X STR_HLINE
    PRINT_STR "Tests Completed.\r\n"
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

  loop:
    rjmp    loop                        ; End of tests
ENDF main
