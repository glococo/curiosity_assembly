; File: Drivers/SINEWAVE/driver.S
; Description: Precomputed sine wave generator using a Quarter-wave table.
;              Efficiently reconstructs full wave using a triangle-counter (0-200).
;

#define _PRECOMPUTE_SINWAVE(name)   SINEWAVE_DEFINE name

.macro SINEWAVE_DEFINE name
  .pushsection .data
    \name\()_pos:   .byte 0          ; Triangle counter (0..200)
    \name\()_fall:  .byte 0          ; Direction flag (0: rising, 1: falling)
    \name\()_ptr:   .word 0          ; Flash table pointer
  .popsection

  .pushsection .progmem.rodata
    \name\()_table:
          .word 0, 8, 16, 24, 32, 40, 48, 56
          .word 64, 72, 80, 88, 96, 104, 111, 119
          .word 127, 135, 143, 150, 158, 166, 173, 181
          .word 188, 196, 203, 210, 218, 225, 232, 239
          .word 246, 253, 260, 267, 274, 281, 287, 294
          .word 300, 307, 313, 319, 326, 332, 338, 344
          .word 350, 356, 361, 367, 373, 378, 383, 389
          .word 394, 399, 404, 409, 413, 418, 423, 427
          .word 431, 436, 440, 444, 448, 452, 455, 459
          .word 462, 466, 469, 472, 475, 478, 481, 483
          .word 486, 488, 491, 493, 495, 497, 499, 500
          .word 502, 503, 505, 506, 507, 508, 509, 509
          .word 510, 510, 511, 511, 511
  .popsection

  PUSH_MANY r22, r23
    ldi2    r22, MAPPED_PROGMEM_START + \name\()_table
    sts2    \name\()_ptr, r22
  POP_MANY r23, r22
.endm

; Function: SINEWAVE_Get
; Description: Calculates the next 10-bit sine wave value (0-1023).
;              Uses the 'sine' instance state.
; Outputs: r23:r22 - Next sine wave value
FUNC SINEWAVE_Get
  PUSH_MANY r16, r17, r18, r19, XL, XH
    lds2    XL, sine_ptr             ; Load table base address
    lds     r18, sine_pos            ; Load current triangle position (0..200)
    
    mov     r16, r18
    cpi     r16, 100
    brsh    .L_pos_half              ; If pos >= 100, upper half of wave
    
  .L_neg_half:
    ; Index = 100 - pos (mirroring back from 90 to 0 degrees)
    ldi     r17, 100
    sub     r17, r16
    mov     r16, r17
    lsl     r16                      ; *2 for word table
    add     XL, r16
    adc     XH, __zero_reg__
    ld      r22, X+
    ld      r23, X                   ; r23:r22 = table_val (0..511)
    
    ; Trough half: result = 512 - table_val
    ldi2    r18, 511
    sub     r18, r22
    sbc     r19, r23
    movw    r22, r18
    rjmp    .L_update_state

  .L_pos_half:
    ; Index = pos - 100 (moving from 0 to 90 degrees)
    subi    r16, 100
    lsl     r16                      ; *2 for word table
    add     XL, r16
    adc     XH, __zero_reg__
    ld      r22, X+
    ld      r23, X                   ; r23:r22 = table_val (0..511)
    
    ; Peak half: result = 512 + table_val
    ldi2    r18, 512
    add     r22, r18
    adc     r23, r19

  .L_update_state:
    lds     r18, sine_pos
    lds     r16, sine_fall           ; Direction flag
    tst     r16
    brne    .L_falling
    
  .L_rising:
    cpi     r18, 200                 ; At top?
    breq    .L_set_fall
    inc     r18
    rjmp    .L_save_exit
  .L_set_fall:
    ldi     r16, 1
    sts     sine_fall, r16
    dec     r18
    rjmp    .L_save_exit
    
  .L_falling:
    tst     r18                      ; At bottom?
    breq    .L_set_rise
    dec     r18
    rjmp    .L_save_exit
  .L_set_rise:
    sts     sine_fall, __zero_reg__
    inc     r18

  .L_save_exit:
    sts     sine_pos, r18
  POP_MANY XH, XL, r19, r18, r17, r16
  ret
ENDF SINEWAVE_Get
