#define _SLEEP()          HAL_SLEEP
#define _SLEEP_STANDBY()  HAL_SLEEP 1
#define _SLEEP_PDOWN()    HAL_SLEEP 2
#define _SLEEP_INT_ALL()  HAL_SLPCTRL_INT_ALL
#define _SLEEP_MODE(m)    HAL_SLEEP_MODE m

.macro HAL_SLEEP_MODE mode=0
  PUSH    r16
    ldi     r16, SLPCTRL_SEN_bm | ( \mode << 1 )
    sts     SLPCTRL_CTRLA, r16
  POP     r16
.endm

.macro HAL_SLEEP mode=0
  PUSH    r18
    ldi     r18, SLPCTRL_SEN_bm | ( \mode << 1 )
    sts     SLPCTRL_CTRLA, r18
  POP     r18
    sleep
.endm

.macro HAL_SLPCTRL_INT_ALL
    sts     SLPCTRL_INTCTRL, __full_reg__
.endm
