; File: Examples/Math_tests/main.S
; Description: Comprehensive math library tests with USART output.
; Target: AVR Dx Ex Family Cores

.section        .progmem.rodata
STR_START:      .asciz "    AVR-DEV Math Library Test Suite"
STR_HLINE:      .asciz "\r\n----------------------------------------\r\n"

; Define a 64-byte Dev-Ring-Buffer for USART0 (regular speed)
HAL_DEVICEBUFFER_DEFINE  USART0_TX_DEVBUFFER, 256, USART0_ADDR

DEFUN main
    rcall   HAL_BOARD_SETUP
    HAL_DEVICEBUFFER_INIT USART0_TX_DEVBUFFER     ; Initialize the USART ring buffer

    PRINT_STR_X STR_HLINE
    PRINT_STR_X STR_START                         ; Welcome to MATH test
    PRINT_STR_X STR_HLINE

    ; Function PRINT_STR do not check for duplicates, avoid using for repeated strings since it will copy again the same string.
    PRINT_STR "\r\nTesting hw mul 8-bit Operation:\r\n" ; --- 8-bit Tests ---
    PRINT_STR "  MUL 8x8: 246 * 251 = "                 ; MUL 8 x 8: 246 * 251 = 61746

    ldi     r22, 246
    ldi     r18, 251
    mul     r22, r18
    movw    r22, r0
    rcall   HAL_PRINT_UINT16_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MULS 8x8: 89 * -102 = "
    ldi     r22, 89
    ldi     r18, -102
    muls    r22, r18
    movw    r22, r0
    rcall   HAL_PRINT_INT16_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MULSU 8x8: 189 * -102 = "
    ldi     r22, 189
    ldi     r18, -102
    mulsu   r18, r22
    movw    r22, r0
    rcall   HAL_PRINT_INT16_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "\r\nMATH MUL 16-bit Operations:\r\n"  ; --- 16-bit Tests ---
    PRINT_STR "  MUL 16x16_16: 123 * 456 = "           ; MATH_MUL_16_16: 123 * 456 = 56088
    ldi     r22, lo8(123)
    ldi     r23, hi8(123)
    ldi     r18, lo8(456)
    ldi     r19, hi8(456)
    rcall   MATH_MUL_16_16
    rcall   HAL_PRINT_UINT16_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MUL 16x16_32: 1623 * 4256 = "           ; MATH_MUL_16_32: 1623 * 456 =
    ldi     r22, lo8(1623)
    ldi     r23, hi8(1623)
    ldi     r18, lo8(4256)
    ldi     r19, hi8(4256)
    rcall   MATH_MUL_16_32
    rcall   HAL_PRINT_UINT32_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MAC 16x16_16: 1000 + (10 * 20) = "      ; MATH_MAC_16_16: 1000 + (10 * 20) = 1200
    ldi     r22, lo8(1000)
    ldi     r23, hi8(1000)
    ldi     r18, lo8(10)
    ldi     r19, hi8(10)
    ldi     r20, lo8(20)
    ldi     r21, hi8(20)
    rcall   MATH_MAC_16_16
    ldi   XL, lo8( USART0_TX_DEVBUFFER )
    ldi   XH, hi8( USART0_TX_DEVBUFFER )
    rcall   HAL_PRINT_UINT16_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MAC 16x16_32: 1234 + (810 * 1120) = "      ; MATH_MAC_16_16: 1234 + (810 * 1120) =
    ldi     r22, lo8(1234)
    ldi     r23, hi8(1234)
    ldi     r18, lo8(810)
    ldi     r19, hi8(810)
    ldi     r20, lo8(1120)
    ldi     r21, hi8(1120)
    rcall   MATH_MAC_16_32
    ldi   XL, lo8( USART0_TX_DEVBUFFER )
    ldi   XH, hi8( USART0_TX_DEVBUFFER )
    rcall   HAL_PRINT_UINT32_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MUL_S 16_32: -100 * 500 = "          ; MATH_MUL_S_16_32: -100 * 500 = -50000
    ldi     r22, lo8(-100)
    ldi     r23, hi8(-100)
    ldi     r18, lo8(500)
    ldi     r19, hi8(500)
    rcall   MATH_MUL_S_16_32
    rcall   HAL_PRINT_INT32_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "\r\nMATH_MUL 32-bit Operations:\r\n"    ; --- 32-bit Tests ---
    PRINT_STR "  MUL 32x32_32: 10000 * 20000 = "         ; MATH_MUL_32_32: 10000 * 20000 = 200,000,000
    ldi     r22, lo8(10000)
    ldi     r23, hi8(10000)
    ldi     r24, 0
    ldi     r25, 0
    ldi     r18, lo8(20000)
    ldi     r19, hi8(20000)
    ldi     r20, 0
    ldi     r21, 0
    rcall   MATH_MUL_32_32
    rcall   HAL_PRINT_UINT32_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MUL 32x32_64: 24231033 * 9827352 = "
    ldi     r22, lo8(24231033)
    ldi     r23, hi8(24231033)
    ldi     r24, hlo8(24231033)
    ldi     r25, hhi8(24231033)
    ldi     r18, lo8(9827352)
    ldi     r19, hi8(9827352)
    ldi     r20, hlo8(9827352)
    ldi     r21, hhi8(9827352)
    rcall   MATH_MUL_32_64
    ldi   XL, lo8( USART0_TX_DEVBUFFER )
    ldi   XH, hi8( USART0_TX_DEVBUFFER )
    rcall   HAL_PRINT_UINT64_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MAC 32_32: 515 + (105 * 92) = "
    ldi     r22, lo8(515)
    ldi     r23, hi8(515)
    ldi     r24, 0
    ldi     r25, 0
    ldi     r18, lo8(105)
    ldi     r19, hi8(105)
    ldi     r20, 0
    ldi     r21, 0
    ldi     r26, lo8(92)
    ldi     r27, hi8(92)
    ldi     r28, 0
    ldi     r29, 0
    rcall   MATH_MAC_32_32
    ldi   XL, lo8( USART0_TX_DEVBUFFER )
    ldi   XH, hi8( USART0_TX_DEVBUFFER )
    rcall   HAL_PRINT_UINT32_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MUL_S 32_64: -1124 * 1234567 = "
    ; A = -1124
    ldi     r22, lo8(-1124)
    ldi     r23, hi8(-1124)
    ldi     r24, 0xFF
    ldi     r25, 0xFF
    ; B = 1234567
    ldi     r18, lo8(1234567)
    ldi     r19, hi8(1234567)
    ldi     r20, hlo8(1234567)
    ldi     r21, hhi8(1234567)
    rcall   MATH_MUL_S_32_64
    rcall   HAL_PRINT_INT64_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "\r\nMATH_MUL 64-bit Operations:\r\n"    ; --- 64-bit Tests ---
    PRINT_STR "  MUL 64_64: 12345678 * 89 = "
    ; B = 89
    ldi     r16, 89
    mov     r10, r16
    CLR_BLOCK r11, 7
    ; A = 12345678
    ldi     r18, lo8(12345678)
    ldi     r19, hi8(12345678)
    ldi     r20, hlo8(12345678)
    ldi     r21, hhi8(12345678)
    CLR_BLOCK r22, 4
    rcall   MATH_MUL_64_64
    ldi   XL, lo8( USART0_TX_DEVBUFFER )
    ldi   XH, hi8( USART0_TX_DEVBUFFER )
    rcall   HAL_PRINT_UINT64_REG
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR_X STR_HLINE
    PRINT_STR "Tests Completed.\r\n"
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

  loop:
    rjmp    loop

ENDF main
