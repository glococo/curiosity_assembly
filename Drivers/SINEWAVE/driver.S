; File: Drivers/SINEWAVE/driver.S
; Description: Precomputed sine wave generator using a Quarter-wave table.
;              Efficiently reconstructs full wave using a triangle-counter (0-200).
;
;
; Javascript table generation code
;   Formula: CenterOffset + (Amplitude * sin(2 * PI * currentStep / totalSteps))
;
;   const steps = 400, center = 512, amp = 511, values = [];
;   for (let i = 0; i < steps; i++) {
;     let val = Math.round(center + amp * Math.sin((2 * Math.PI) * (i / steps)));
;     values.push(val<<6);
;   }
;   for (let i = 0; i < values.length; i += 8) {
;      console.log('          .word ' + values.slice(i, i + 8).join(', '));
;   }

#define _PRECOMPUTE_SINWAVE(name)   SINEWAVE_DEFINE name
#define _FULL_SINWAVE()           SINEWAVE_FULL

.macro SINEWAVE_FULL
  .pushsection .progmem.rodata
    full_sinewave_table:
      .word 32768, 33280, 33792, 34304, 34816, 35328, 35840, 36352
      .word 36864, 37376, 37888, 38400, 38912, 39424, 39872, 40384
      .word 40896, 41408, 41920, 42368, 42880, 43392, 43840, 44352
      .word 44800, 45312, 45760, 46208, 46720, 47168, 47616, 48064
      .word 48512, 48960, 49408, 49856, 50304, 50752, 51136, 51584
      .word 51968, 52416, 52800, 53184, 53632, 54016, 54400, 54784
      .word 55168, 55552, 55872, 56256, 56640, 56960, 57280, 57664
      .word 57984, 58304, 58624, 58944, 59200, 59520, 59840, 60096
      .word 60352, 60672, 60928, 61184, 61440, 61696, 61888, 62144
      .word 62336, 62592, 62784, 62976, 63168, 63360, 63552, 63680
      .word 63872, 64000, 64192, 64320, 64448, 64576, 64704, 64768
      .word 64896, 64960, 65088, 65152, 65216, 65280, 65344, 65344
      .word 65408, 65408, 65472, 65472, 65472, 65472, 65472, 65408
      .word 65408, 65344, 65344, 65280, 65216, 65152, 65088, 64960
      .word 64896, 64768, 64704, 64576, 64448, 64320, 64192, 64000
      .word 63872, 63680, 63552, 63360, 63168, 62976, 62784, 62592
      .word 62336, 62144, 61888, 61696, 61440, 61184, 60928, 60672
      .word 60352, 60096, 59840, 59520, 59200, 58944, 58624, 58304
      .word 57984, 57664, 57280, 56960, 56640, 56256, 55872, 55552
      .word 55168, 54784, 54400, 54016, 53632, 53184, 52800, 52416
      .word 51968, 51584, 51136, 50752, 50304, 49856, 49408, 48960
      .word 48512, 48064, 47616, 47168, 46720, 46208, 45760, 45312
      .word 44800, 44352, 43840, 43392, 42880, 42368, 41920, 41408
      .word 40896, 40384, 39872, 39424, 38912, 38400, 37888, 37376
      .word 36864, 36352, 35840, 35328, 34816, 34304, 33792, 33280
      .word 32768, 32256, 31744, 31232, 30720, 30208, 29696, 29184
      .word 28672, 28160, 27648, 27136, 26624, 26112, 25664, 25152
      .word 24640, 24128, 23616, 23168, 22656, 22144, 21696, 21184
      .word 20736, 20224, 19776, 19328, 18816, 18368, 17920, 17472
      .word 17024, 16576, 16128, 15680, 15232, 14784, 14400, 13952
      .word 13568, 13120, 12736, 12352, 11904, 11520, 11136, 10752
      .word 10368, 9984, 9664, 9280, 8896, 8576, 8256, 7872
      .word 7552, 7232, 6912, 6592, 6336, 6016, 5696, 5440
      .word 5184, 4864, 4608, 4352, 4096, 3840, 3648, 3392
      .word 3200, 2944, 2752, 2560, 2368, 2176, 1984, 1856
      .word 1664, 1536, 1344, 1216, 1088, 960, 832, 768
      .word 640, 576, 448, 384, 320, 256, 192, 192
      .word 128, 128, 64, 64, 64, 64, 64, 128
      .word 128, 192, 192, 256, 320, 384, 448, 576
      .word 640, 768, 832, 960, 1088, 1216, 1344, 1536
      .word 1664, 1856, 1984, 2176, 2368, 2560, 2752, 2944
      .word 3200, 3392, 3648, 3840, 4096, 4352, 4608, 4864
      .word 5184, 5440, 5696, 6016, 6336, 6592, 6912, 7232
      .word 7552, 7872, 8256, 8576, 8896, 9280, 9664, 9984
      .word 10368, 10752, 11136, 11520, 11904, 12352, 12736, 13120
      .word 13568, 13952, 14400, 14784, 15232, 15680, 16128, 16576
      .word 17024, 17472, 17920, 18368, 18816, 19328, 19776, 20224
      .word 20736, 21184, 21696, 22144, 22656, 23168, 23616, 24128
      .word 24640, 25152, 25664, 26112, 26624, 27136, 27648, 28160
      .word 28672, 29184, 29696, 30208, 30720, 31232, 31744, 32256
  .popsection
    ; Load sinewave table in X pointer
    ldi2    XL, MAPPED_PROGMEM_START + full_sinewave_table  ; Load table base address
.endm

; Function: FULLSINEWAVE_Get
; Description: Get the next 10-bit sine wave value (0-1023).
; Outputs:     r23:r22 - Next sine wave value
FUNC FULLSINEWAVE_Get
    ld      r22, X+
    ld      r23, X+
    cpi2    XL, MAPPED_PROGMEM_START + full_sinewave_table + 800
    brne    0f
    ldi2    XL, MAPPED_PROGMEM_START + full_sinewave_table  ; Load table base address
  0:
ENDF FULLSINEWAVE_Get

; Javascript table generation code
;    const steps = 100, res = 511, values = [];
;    for (let i = 0; i <= steps; i++) {
;       values.push(Math.round(res * Math.sin((Math.PI / 2) * (i / steps))));
;    }
;    for (let i = 0; i < values.length; i += 8) {
;       console.log('          .word ' + values.slice(i, i + 8).join(', '));
;    }

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
