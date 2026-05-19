; -----------------------------------------------------------------------------
; File: Examples/29_My_C_code/main.S
; Description: Allow to mix C code.
;              - Pass and handle return values values.
;              - Send a uint8_t value, return value * 1000
; -----------------------------------------------------------------------------

#include "my_c_code.h"

FUNC main
    _BOARD_SETUP()                                    ; Basic board initialization
    _DEVBUFFER(DEVBUFFER, 128, USART_ADDR)            ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __\r\n")
    _STR("__ USART - Calling an extern C function __ \r\n")
    _STR_FLUSH()

  loop:
    _STR("Delay 4 * get_blink_interval.c\n\r")$ _STR_FLUSH()

    ; 2. Pass arguments according to AVR ABI.
    ; For an 8-bit argument, the AVR GCC ABI uses register r24.
    ldi     r24, 4                                    ; Passing '4' as the multiplier argument

    ; 3. Call the C function
    call    get_blink_interval                        ; The program jumps to the C function

    ; 4. Handle the return value
    ; The 16-bit return value from C will be placed back in r25:r24.
    ; HAL_SOFT_DELAY_MS take r23:r22 as uint16_t milliseconds
    movw    r22, r24
    call    HAL_SOFT_DELAY_MS                         ; Call the HAL soft delay function

    jmp     loop                                      ; Repeat indefinitely

ENDF main


; Notes:
; AVR-GCC passes arguments in pairs of registers starting from R25 down to R8 (specifically pairs R25:R24, R23:R22, etc.).
; Return Values: An 8-bit integer return value is always handed back to your assembly code in R24.
; A 16-bit return value is handed back in R25:R24.
;
; Call-Saved vs. Call-Clobbered Registers
; When your Assembly code transfers control over to the C function (call calculate_blink_interval), you have to be careful
; about what registers the C function might overwrite.
;
; Call-Clobbered (Scratch Registers):
; R18–R27, R30–R31. The C function is free to change these. If you have important data in R18 or R20 before you call
; the C function, expect them to be wiped out unless you push them to the stack before the call.

; Call-Saved Registers:
; R2–R17, R28–R29. The C function is guaranteed to leave these untouched (or restore them before returning). It is safe
; to keep your long-term variables here.

; Enable DEBUG=true in curiosity.sh, compile and see the output
; Double check you have push/pop used registers

/*
..
..
..
00000102 <__call_main>:
 102:	76 d1       	rcall	.+748    	; 0x3f0 <main>
 104:	9f c1       	rjmp	.+830    	; 0x444 <_exit>

00000106 <__bad_interrupt>:
 106:	7c cf       	rjmp	.-264    	; 0x0 <__vectors>

00000108 <get_blink_interval>:
 108:	28 ee       	ldi	r18, 0xE8	; 232
 10a:	33 e0       	ldi	r19, 0x03	; 3
 10c:	48 2f       	mov	r20, r24
 10e:	42 9f       	mul	r20, r18
 110:	c0 01       	movw	r24, r0
 112:	43 9f       	mul	r20, r19
 114:	90 0d       	add	r25, r0
 116:	11 24       	eor	r1, r1
 118:	08 95       	ret

0000011a <HAL_SOFT_DELAY_MS>:
 11a:	8f 93       	push	r24
 11c:	9f 93       	push	r25

0000011e <L0^AL2>:
 11e:	80 91 02 78 	lds	r24, 0x7802	; 0x807802 <HAL_ONE_MS_DELAY>
 122:	90 91 03 78 	lds	r25, 0x7803	; 0x807803 <HAL_ONE_MS_DELAY+0x1>

00000126 <L0^AL3>:
 126:	01 97       	sbiw	r24, 0x01	; 1
..
..
..
*/
