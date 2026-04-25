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
#include "assert.S"
.section        .progmem.rodata
STR_HLINE:      .asciz "\r\n----------------------------------------\r\n"
; -----------------------------------------------------------------------------
; Function: main
; Description: Application entry point. Executes a series of math tests
;              and prints the results to USART.
; -----------------------------------------------------------------------------
FUNC main
    rcall   HAL_BOARD_SETUP                   ; Basic board initialization
    _DEVBUFFER(TX_DEVBUFFER, 256, USART_ADDR) ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __ \r\n")
    _STR("__ AVR-DEV Math Library Test Suite!\r\n")
    _STR("----------------------------------------\r\n")$ _STR_FLUSH()

    ldi   r22, -82
    _STR("  print_tst  s8: -82 = ")$ _STR_S8(r22)$ _STR("\r\n")
    ldi2  r22, -27182
    _STR("  print_tst s16: -27182 = ")$ _STR_S16(r22)$ _STR("\r\n")
    ldi4  r22, -1147483048
    _STR("  print_tst s32: -1147483048 = ")$ _STR_S32(r22)$ _STR("\r\n")
    ldi8  r18, 4700090564608773424
    _STR("  print_tst u64: 4700090564608773424 = ")$ _STR_U64(r18)$ _STR("\r\n")
    ldi8  r18, -4700090564608773424
    _STR("  print_tst s64: -4700090564608773424 = ")$ _STR_S64(r18)$ _STR("\r\n")$ _STR_FLUSH()

    ; --- 8-bit Hardware MUL Tests ---
    _STR("\r\nTesting hw mul 8-bit Operation:\r\n")$ _STR_FLUSH()
    _ASSERT8u( 246,  251,  246*251)
    _ASSERT8s(-102,   89, -102*89 )
    _ASSERT8x(-102,  189, -102*189)

    ; --- 16-bit Library Tests ---
    _STR("\r\nMATH MUL 16-bit Operations:\r\n")
    _ASSERT16_(  623,  103,  623*103  )
    _ASSERT16u( 1623, 4256, 1623*4256 )
    _ASSERT16s(-1623, 4256,-1623*4256 )
    _ASSERT16x(-1623,17256,-1623*17256)

    _ASSERT16mac16(  12055, 1234,   42, 12055+(1234*42) )
    _ASSERT16mac32(  12055, 1234, 2345, 12055+(1234*2345) )

    ; --- 32-bit Library Tests ---
    _STR("\r\nMATH_MUL 32-bit Operations:\r\n")
    _ASSERT32_(     11621, 345678, 11621*345678  )
    _ASSERT32mac(   11621, 345678, 148, 148+(11621*345678) )
    _ASSERT32u(1234567890, 1234567890,  1234567890*1234567890 )
    _ASSERT32s(-234567890, -234567890,  -234567890*-234567890 )
    _ASSERT32x(-234567890,  234567890,  -234567890* 234567890 )

    ; --- 64-bit Library Tests ---
    _STR("\r\nMATH_MUL 64-bit Operations:\r\n")
    _ASSERT64u( 12345678901,  1234567890,  12345678901* 1234567890 )
    _ASSERT64s(  1234567890, -1234567890,   1234567890*-1234567890 )
    _ASSERT64x( -1234567890,  1234567890,  -1234567890* 1234567890 )

    _STR("----------------------------------------\r\n")
    _STR("Tests Completed.\r\n")$ _STR_FLUSH()

  loop:
    rjmp    loop                              ; End of tests
ENDF main
