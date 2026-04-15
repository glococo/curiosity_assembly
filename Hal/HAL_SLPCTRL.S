#define _SLEEP(mode)  HAL_SLEEP mode

.macro HAL_SLEEP mode=0
  PUSH    r18
  ldi     r18, SLPCTRL_SEN_bm | ( \mode << 1 )
  sts     SLPCTRL_CTRLA, r18
  POP     r18
  sleep
.endm
