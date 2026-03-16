; File: Hal/HAL_RTC.S
; Description: Modern RTC helper library for AVR-Dx/Ex families.
;  - Safe register writes with sync-busy guards
;  - Helper macros for static (compile-time) period configuration
;  - Convenience PIT (Periodic Interrupt Timer) setup helpers

; -----------------------------------------------------------------------------
; Local copies of prescaler/period values (the vendor headers expose them as
; enum constants, which are not visible to the assembler preprocessor). Provide
; fallbacks only when they are missing so C builds keep their originals.
; -----------------------------------------------------------------------------
#ifndef RTC_PRESCALER_DIV1_gc
#  define RTC_PRESCALER_DIV1_gc    (0x00<<3)
#  define RTC_PRESCALER_DIV2_gc    (0x01<<3)
#  define RTC_PRESCALER_DIV4_gc    (0x02<<3)
#  define RTC_PRESCALER_DIV8_gc    (0x03<<3)
#  define RTC_PRESCALER_DIV16_gc   (0x04<<3)
#  define RTC_PRESCALER_DIV32_gc   (0x05<<3)
#  define RTC_PRESCALER_DIV64_gc   (0x06<<3)
#  define RTC_PRESCALER_DIV128_gc  (0x07<<3)
#  define RTC_PRESCALER_DIV256_gc  (0x08<<3)
#  define RTC_PRESCALER_DIV512_gc  (0x09<<3)
#  define RTC_PRESCALER_DIV1024_gc (0x0A<<3)
#  define RTC_PRESCALER_DIV2048_gc (0x0B<<3)
#  define RTC_PRESCALER_DIV4096_gc (0x0C<<3)
#  define RTC_PRESCALER_DIV8192_gc (0x0D<<3)
#  define RTC_PRESCALER_DIV16384_gc (0x0E<<3)
#  define RTC_PRESCALER_DIV32768_gc (0x0F<<3)
#endif

#ifndef RTC_PERIOD_OFF_gc
#  define RTC_PERIOD_OFF_gc     (0x00<<3)
#  define RTC_PERIOD_CYC4_gc    (0x01<<3)
#  define RTC_PERIOD_CYC8_gc    (0x02<<3)
#  define RTC_PERIOD_CYC16_gc   (0x03<<3)
#  define RTC_PERIOD_CYC32_gc   (0x04<<3)
#  define RTC_PERIOD_CYC64_gc   (0x05<<3)
#  define RTC_PERIOD_CYC128_gc  (0x06<<3)
#  define RTC_PERIOD_CYC256_gc  (0x07<<3)
#  define RTC_PERIOD_CYC512_gc  (0x08<<3)
#  define RTC_PERIOD_CYC1024_gc (0x09<<3)
#  define RTC_PERIOD_CYC2048_gc (0x0A<<3)
#  define RTC_PERIOD_CYC4096_gc (0x0B<<3)
#  define RTC_PERIOD_CYC8192_gc (0x0C<<3)
#  define RTC_PERIOD_CYC16384_gc (0x0D<<3)
#  define RTC_PERIOD_CYC32768_gc (0x0E<<3)
#  define RTC_PERIOD_CYC65536_gc (0x0F<<3)
#endif

; -----------------------------------------------------------------------------
; Compile-time helpers (use only with constants)
; -----------------------------------------------------------------------------
#define HAL_RTC_MS_TO_TICKS(ms, div)  (((BOARD_CLOCK_RTC) / (div) * (ms) + 999) / 1000)
#define HAL_RTC_SEC_TO_TICKS(s, div)  HAL_RTC_MS_TO_TICKS((s) * 1000, div)

.macro HAL_RTC_INIT_STATIC ticks, prescaler_gc
    .if (\ticks) > 65535
        .error "HAL_RTC_INIT_STATIC: PER overflows 16-bit register"
    .endif
    ldi     r22, lo8( \ticks )
    ldi     r23, hi8( \ticks )
    ldi     r18, RTC_RUNSTDBY_bm | (\prescaler_gc) | RTC_RTCEN_bm
    ldi     r19, RTC_OVF_bm
    rcall   HAL_RTC_CONFIG
.endm

.macro HAL_RTC_INIT_MS ms, prescaler_div, prescaler_gc
    HAL_RTC_INIT_STATIC HAL_RTC_MS_TO_TICKS(\ms, \prescaler_div), \prescaler_gc
.endm

.macro HAL_RTC_PIT_ENABLE period_gc
    ldi     r18, \period_gc | RTC_PITEN_bm
    ldi     r19, RTC_PI_bm
    rcall   HAL_RTC_PIT_CONFIG
.endm

.macro HAL_RTC_PIT_DISABLE
    ldi     r18, 0
    rcall   HAL_RTC_PIT_OFF
.endm

; -----------------------------------------------------------------------------
; Low-level synchronisation helpers
; -----------------------------------------------------------------------------

DEFUN HAL_RTC_WRITE_CTRLA            ; r18 = new CTRLA value
  HAL_RTC_WRITE_CTRLA:
  PUSH  r20
  0:  lds   r20, RTC_STATUS
      sbrc  r20, RTC_CTRLBUSY_bp
      rjmp 0b                      ; wait for sync window
      sts   RTC_CTRLA, r18
  1:  lds   r20, RTC_STATUS
      sbrc  r20, RTC_CTRLBUSY_bp
      rjmp 1b                      ; wait for write to complete
  POP  r20
  ret
ENDF HAL_RTC_WRITE_CTRLA

DEFUN HAL_RTC_SET_PERIOD             ; r23:r22 = PER value
  HAL_RTC_SET_PERIOD:
  PUSH  r20
  0:  lds   r20, RTC_STATUS
      sbrc  r20, RTC_PERBUSY_bp
      rjmp 0b
      sts   RTC_PERL, r22
      sts   RTC_PERH, r23
  POP  r20
  ret
ENDF HAL_RTC_SET_PERIOD

DEFUN HAL_RTC_SET_COUNT              ; r23:r22 = CNT value
  HAL_RTC_SET_COUNT:
  PUSH  r20
  0:  lds   r20, RTC_STATUS
      sbrc  r20, RTC_CNTBUSY_bp
      rjmp 0b
      sts   RTC_CNTL, r22
      sts   RTC_CNTH, r23
  POP  r20
  ret
ENDF HAL_RTC_SET_COUNT

DEFUN HAL_RTC_GET_COUNT              ; return r23:r22 = CNT
  HAL_RTC_GET_COUNT:
  PUSH  r20
  0:  lds   r20, RTC_STATUS
      sbrc  r20, RTC_CNTBUSY_bp
      rjmp 0b
      lds   r22, RTC_CNTL
      lds   r23, RTC_CNTH
  POP  r20
  ret
ENDF HAL_RTC_GET_COUNT

DEFUN HAL_RTC_SET_COMPARE            ; r23:r22 = CMP value
  HAL_RTC_SET_COMPARE:
  PUSH  r20
  0:  lds   r20, RTC_STATUS
      sbrc  r20, RTC_CMPBUSY_bp
      rjmp 0b
      sts   RTC_CMPL, r22
      sts   RTC_CMPH, r23
  POP  r20
  ret
ENDF HAL_RTC_SET_COMPARE

; -----------------------------------------------------------------------------
; Public configuration helpers
; -----------------------------------------------------------------------------

; Inputs:
;   r23:r22 -> PER value (ticks)
;   r19     -> INTCTRL mask (e.g., RTC_OVF_bm | RTC_CMP_bm)
;   r18     -> CTRLA value (prescaler | runstdby | RTC_RTCEN_bm)
DEFUN HAL_RTC_CONFIG
  HAL_RTC_CONFIG:
  PUSH_MANY r20, r21
    push    r18                      ; save requested CTRLA bits

    ; Disable before reconfiguring
  0:  lds   r20, RTC_STATUS
      sbrc  r20, RTC_CTRLBUSY_bp
      rjmp 0b
      lds   r21, RTC_CTRLA
      andi  r21, ~RTC_RTCEN_bm
      mov   r18, r21
      rcall HAL_RTC_WRITE_CTRLA

    ; Program PER and reset CNT
      rcall HAL_RTC_SET_PERIOD
      clr   r22
      clr   r23
      rcall HAL_RTC_SET_COUNT

    ; Interrupts and flags
      sts   RTC_INTCTRL, r19
      ldi   r20, RTC_OVF_bm | RTC_CMP_bm
      sts   RTC_INTFLAGS, r20
      ldi   r20, RTC_PI_bm
      sts   RTC_PITINTFLAGS, r20

    ; Re-enable with requested settings
      pop   r18
      rcall HAL_RTC_WRITE_CTRLA
  POP_MANY r21, r20
  ret
ENDF HAL_RTC_CONFIG

DEFUN HAL_RTC_STOP
  HAL_RTC_STOP:
  PUSH  r19
  0:  lds   r19, RTC_STATUS
      sbrc  r19, RTC_CTRLBUSY_bp
      rjmp 0b
      lds   r19, RTC_CTRLA
      andi  r19, ~RTC_RTCEN_bm
      mov   r18, r19
      rcall HAL_RTC_WRITE_CTRLA
  POP  r19
  ret
ENDF HAL_RTC_STOP

DEFUN HAL_RTC_START
  HAL_RTC_START:
  PUSH  r19
  0:  lds   r19, RTC_STATUS
      sbrc  r19, RTC_CTRLBUSY_bp
      rjmp 0b
      lds   r19, RTC_CTRLA
      ori   r19, RTC_RTCEN_bm
      mov   r18, r19
      rcall HAL_RTC_WRITE_CTRLA
  POP  r19
  ret
ENDF HAL_RTC_START

; PIT setup: r18 = PITCTRLA value (RTC_PERIOD_*_gc | RTC_PITEN_bm), r19 = INTCTRL
DEFUN HAL_RTC_PIT_CONFIG
  HAL_RTC_PIT_CONFIG:
  PUSH  r20
      sts   RTC_PITINTCTRL, r19
      ldi   r20, RTC_PI_bm
      sts   RTC_PITINTFLAGS, r20
      sts   RTC_PITCTRLA, r18
  POP  r20
  ret
ENDF HAL_RTC_PIT_CONFIG

DEFUN HAL_RTC_PIT_OFF
  HAL_RTC_PIT_OFF:
  PUSH  r18
      sts   RTC_PITCTRLA, __zero_reg__
      sts   RTC_PITINTCTRL, __zero_reg__
      sts   RTC_PITINTFLAGS, __zero_reg__
  POP  r18
  ret
ENDF HAL_RTC_PIT_OFF

; -----------------------------------------------------------------------------
; Compatibility & convenience wrappers
; -----------------------------------------------------------------------------

DEFUN RTC_INIT_ONE_SECOND
  RTC_INIT_ONE_SECOND:
    HAL_RTC_INIT_MS 1000, 256, RTC_PRESCALER_DIV256_gc
    ret
ENDF RTC_INIT_ONE_SECOND

DEFUN RTC_INIT_THREE_SECOND
  RTC_INIT_THREE_SECOND:
    HAL_RTC_INIT_MS 3000, 256, RTC_PRESCALER_DIV256_gc
    ret
ENDF RTC_INIT_THREE_SECOND
