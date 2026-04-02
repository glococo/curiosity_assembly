; -----------------------------------------------------------------------------
; File: Examples/06_Math_lib/main.S
; Description: Comprehensive test suite for the AVR-DEV math library.
;              - Tests 8, 16, 32, and 64-bit multiplication.
;              - Tests Multiply-Accumulate (MAC) operations.
;              - Tests signed and unsigned variants.
;              - Outputs results via USART.
;
; Example Usage:
;   This is a standalone test suite. Compile and flash to a supported AVR board.
;   Connect via USART to see the test results and verify math library correctness.
; -----------------------------------------------------------------------------

.section        .progmem.rodata
STR_START:      .asciz "__ AVR-DEV Math Library Test Suite"
STR_HLINE:      .asciz "\r\n----------------------------------------\r\n"

; Define a 256-byte Dev-Ring-Buffer for USART0 (regular speed)
HAL_DEVICEBUFFER_DEFINE  TX_DEVBUFFER, 256, USART_ADDR

; -----------------------------------------------------------------------------
; Function: main
; Description: Application entry point. Executes a series of math tests
;              and prints the results to USART.
; Inputs:      None
; Outputs:     None
; -----------------------------------------------------------------------------
FUNC main
    rcall   HAL_BOARD_SETUP                   ; Basic board initialization
    HAL_DEVICEBUFFER_INIT TX_DEVBUFFER        ; Initialize USART TX buffer

    ; Set Z to point to the device buffer for all PRINT functions
    ldi2    ZL, TX_DEVBUFFER

    PRINT_STR "__ CURIOSITY ASSEMBLY __ \r\n"
    PRINT_STR_X STR_START                     ; Welcome message
    PRINT_STR_X STR_HLINE

    ; --- 8-bit Hardware MUL Tests ---
    PRINT_STR "\r\nTesting hw mul 8-bit Operation:\r\n"
    PRINT_STR "  MUL 8x8: 246 * 251 = "
    ldi     r22, 246                          ; Load A
    ldi     r18, 251                          ; Load B
    mul     r22, r18                          ; Hardware multiply
    movw    r22, r0                           ; Move result to r23:r22
    rcall   HAL_PRINT_UINT16_REG              ; Print 16-bit result
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MULS 8x8: 89 * -102 = "
    ldi     r22, 89                           ; Load signed A
    ldi     r18, -102                         ; Load signed B
    muls    r22, r18                          ; Signed hardware multiply
    movw    r22, r0                           ; Move result
    rcall   HAL_PRINT_INT16_REG               ; Print signed result
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MULSU 8x8: 189 * -102 = "
    ldi     r22, 189                          ; Load unsigned A
    ldi     r18, -102                         ; Load signed B
    mulsu   r18, r22                          ; Signed * Unsigned hardware multiply
    movw    r22, r0                           ; Move result
    rcall   HAL_PRINT_INT16_REG               ; Print signed result
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    ; --- 16-bit Library Tests ---
    PRINT_STR "\r\nMATH MUL 16-bit Operations:\r\n"
    PRINT_STR "  MUL 16x16_16: 123 * 456 = "
    ldi2    r22, 123                          ; Load 16-bit A
    ldi2    r18, 456                          ; Load 16-bit B
    rcall   MATH_MUL_16_16                    ; 16x16 -> 16-bit
    rcall   HAL_PRINT_UINT16_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MUL 16x16_32: 1623 * 4256 = "
    ldi2    r22, 1623
    ldi2    r18, 4256
    rcall   MATH_MUL_16_32                    ; 16x16 -> 32-bit
    rcall   HAL_PRINT_UINT32_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MAC 16x16_16: 1000 + (10 * 20) = "
    ldi2    r22, 1000                         ; Load Accumulator
    ldi2    r18, 10                           ; Load A
    ldi2    r20, 20                           ; Load B
    rcall   MATH_MAC_16_16                    ; Accum += A * B
    rcall   HAL_PRINT_UINT16_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MAC 16x16_32: 1234 + (810 * 1120) = "
    ldi4    r22, 1234                         ; Load 32-bit Accumulator
    ldi2    r18, 810                          ; Load 16-bit A
    ldi2    r20, 1120                         ; Load 16-bit B
    rcall   MATH_MAC_16_32                    ; 32-bit Accum += 16 * 16
    rcall   HAL_PRINT_UINT32_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MUL_S 16_32: -100 * 500 = "
    ldi2    r22, -100                         ; Load signed 16-bit A
    ldi2    r18, 500                          ; Load 16-bit B
    rcall   MATH_MUL_S_16_32                  ; Signed 16x16 -> 32-bit
    rcall   HAL_PRINT_INT32_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    ; --- 32-bit Library Tests ---
    PRINT_STR "\r\nMATH_MUL 32-bit Operations:\r\n"
    PRINT_STR "  MUL 32x32_32: 10000 * 20000 = "
    ldi4    r22, 10000                        ; Load 32-bit A
    ldi4    r18, 20000                        ; Load 32-bit B
    rcall   MATH_MUL_32_32                    ; 32x32 -> 32-bit
    rcall   HAL_PRINT_UINT32_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MUL 32x32_64: 24231033 * 9827352 = "
    ldi4    r22, 24231033                     ; Load 32-bit A
    ldi4    r18, 9827352                      ; Load 32-bit B
    rcall   MATH_MUL_32_64                    ; 32x32 -> 64-bit
    rcall   HAL_PRINT_UINT64_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MAC 32_32: 515 + (105 * 92) = "
    ldi4    r22, 515                          ; Load 32-bit Accumulator
    ldi4    r18, 105                          ; Load 32-bit A
    ldi4    r26, 92                           ; Load 32-bit B
    rcall   MATH_MAC_32_32                    ; 32-bit Accum += 32 * 32
    rcall   HAL_PRINT_UINT32_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR "  MUL_S 32_64: -1124 * 1234567 = "
    ldi4    r22, -1124                        ; A = -1124 (signed 32-bit)
    ldi4    r18, 1234567                      ; B = 1234567 (32-bit)
    rcall   MATH_MUL_S_32_64                  ; Signed 32x32 -> 64-bit
    rcall   HAL_PRINT_INT64_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    ; --- 64-bit Library Tests ---
    PRINT_STR "\r\nMATH_MUL 64-bit Operations:\r\n"
    PRINT_STR "  MUL 64_64: 812345678 * 3425412589 = "
    ldi8    r16, 3425412589                   ; B = 3425412589 (64-bit)
    MOV_BLOCK r10, r16, 8
    ldi8    r18, 812345678                    ; A = 812345678 (64-bit)
    rcall   MATH_MUL_64_64                    ; 64x64 -> 64-bit
    rcall   HAL_PRINT_UINT64_REG
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    PRINT_STR_X STR_HLINE
    PRINT_STR "Tests Completed.\r\n"
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

  loop:
    rjmp    loop                              ; End of tests
ENDF main
