; HAL - Analog Comparator

#define _AC0_MUX( mux )             HAL_AC_MUX      AC0_MUXCTRL, mux
#define _AC0_DACREF( ref )          HAL_AC_DACREF   AC0_DACREF, ref
#define _AC0_ENABLE( ... )          HAL_AC_ENABLE   AC0_INTCTRL, AC0_CTRLA, ##__VA_ARGS__
#define _AC0_DISABLE()              HAL_AC_DISABLE  AC0_INTCTRL, AC0_CTRLA

.macro HAL_AC_MUX reg, mux
    ldi   r16, \mux
    sts   \reg, r16
.endm

.macro HAL_AC_DACREF reg, ref
    ldi   r16, \ref
    sts   \reg, r16
.endm

.macro HAL_AC_ENABLE reg_int, reg_ctl, int=0, opt=0
    ldi   r16, \int
    sts   \reg_int, r16
    ldi   r16, \opt | AC_ENABLE_bm
    sts   \reg_ctl, r16
.endm

.macro HAL_AC_DISABLE int, ctl
    sts   \int, __zero_reg__
    sts   \ctl, __zero_reg__
.endm
