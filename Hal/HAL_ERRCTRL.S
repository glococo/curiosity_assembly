; ERROR CONTROLLER on SD FAMILY
#define _ERRCTRL_INIT()               HAL_ERRCTRL_INIT
#define _ERRCTRL_NORMAL()             HAL_ERRCTRL_NORMAL
#define _ERRCTRL_RESET_ESF()          HAL_ERRCTRL_RESET_ESF
#define _ERRCTRL_NOTIFICATION_ONLY()  HAL_ERRCTRL_NOTIFICATION_ONLY

.section .bss
HAL_ERR_CAUSE:         .byte 0       ;  8-bit PREVIOUS ERROR CAUSE
HAL_ERR_ESF:           .long 0       ; 32-bit PREVIOUS ERROR ESF

.macro HAL_ERRCTRL_RESET_ESF
    sts     ERRCTRL_ESF, __full_reg__
    sts     ERRCTRL_ESF+1, __full_reg__
    sts     ERRCTRL_ESF+2, __full_reg__
.endm

.macro HAL_ERRCTRL_NORMAL
  PUSH_MANY  r18, r22
    ldi     r22, PORTMUX_HEART_ALT5_gc
    sts     PORTMUX_ERRCTRLROUTEA, r22

    ldi     r22, ERRCTRL_HEART_bm | ERRCTRL_STATE_NORMAL_gc
    _WRITE_PROTECTED(ERRCTRL_CTRLA, r22)
  POP_MANY   r22, r18
.endm

.macro HAL_ERRCTRL_INIT
  PUSH_MANY r18, r19
    lds     r16, ERRCTRL_CAUSE
    sts     HAL_ERR_CAUSE, r16
    lds4    r16, ERRCTRL_ESF
    sts4    HAL_ERR_ESF, r16
    tst4    r16
    breq    0f                                      ; No error: skip ESF clear
    sts     ERRCTRL_ESF, __full_reg__               ; Clear ESF
    sts     ERRCTRL_ESF+1, __full_reg__             ; Clear ESF
    sts     ERRCTRL_ESF+2, __full_reg__             ; Clear ESF
  0:
  POP_MANY r19, r18
.endm
.macro HAL_ERRCTRL_NOTIFICATION_ONLY
  PUSH_MANY r24, r25, r26, r27
    ldi     r24, ERRCTRL_STATE_CONFIG_gc
    _WRITE_PROTECTED(ERRCTRL_CTRLA, r24)            ; Start ERR level configuration

    ldi     r24, 17                                 ; 17 Error causes on SD family
    ldi     r25, ERRCTRL_ERRLVL_NOTIFICATION_gc
    ldi2    XL, ERRCTRL_ESCVREGFAIL
  .L_for:
    st      X+, r25
    dec     r24
    brne    .L_for

    ldi     r24, ERRCTRL_STATE_NORMAL_gc
    _WRITE_PROTECTED(ERRCTRL_CTRLA, r24)            ; End configuration
  POP_MANY r27, r26, r25, r24
.endm
