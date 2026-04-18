#define _SLEEP()          HAL_SLEEP
#define _SLEEP_STANDBY()  HAL_SLEEP 1
#define _SLEEP_PDOWN()    HAL_SLEEP 2
#define _SLEEP_INT_ALL()  HAL_SLPCTRL_INT_ALL

.macro HAL_SLEEP mode=0
  PUSH    r18
    ldi     r18, SLPCTRL_SEN_bm | ( \mode << 1 )
    sts     SLPCTRL_CTRLA, r18
    _DELAY_MS(4)
  POP     r18
    sleep
.endm

.macro HAL_SLPCTRL_INT_ALL
    sts     SLPCTRL_INTCTRL, __full_reg__
.endm
