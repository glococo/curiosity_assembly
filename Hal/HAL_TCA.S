; File: Hal/HAL_TCA.S
; Description: TCA - Timer Counter A helper library for modern AVR (Dx/Ex/SD)
;              Provides comprehensive macros for Single and Split mode configurations.

; --- Primitive Macros (Assembler Phase) ---

.macro HAL_TCA_CONFIG_SINGLE reg_b, reg_d, mode, channels
    ldi     r16, \mode | \channels
    sts     \reg_b, r16
    sts     \reg_d, __zero_reg__
.endm

.macro HAL_TCA_CONFIG_SPLIT reg_d, reg_b, l_ch, h_ch
    ldi     r16, TCA_SPLIT_SPLIT_bm
    sts     \reg_d, r16
    ldi     r16, \l_ch | \h_ch
    sts     \reg_b, r16
.endm

.macro HAL_TCA_CONFIG_BASIC reg_per, val_per, reg_ctrl, val_ctrl
    ldi2    r16, \val_per
    sts2    \reg_per, r16
    ldi     r16, \val_ctrl | TCA_SINGLE_ENABLE_bm
    sts     \reg_ctrl, r16
.endm

; --- API Macros (Preprocessor Phase) ---
#define _TCA_ENABLE(dev, div)      HAL_IO_WRITE _(dev, _SINGLE_CTRLA), (div | TCA_SINGLE_ENABLE_bm)
#define _TCA_DISABLE(dev)          HAL_IO_WRITE _(dev, _SINGLE_CTRLA), 0
#define _TCA_INT(dev, mask)        HAL_IO_WRITE _(dev, _SINGLE_INTCTRL), mask

#define _TCA_SINGLE_MODE(dev, mode, ch_bm) \
    HAL_TCA_CONFIG_SINGLE _(dev, _SINGLE_CTRLB), _(dev, _SINGLE_CTRLD), mode, ch_bm

#define _TCA_SPLIT_MODE(dev, l_ch_bm, h_ch_bm) \
    HAL_TCA_CONFIG_SPLIT _(dev, _SPLIT_CTRLD), _(dev, _SPLIT_CTRLB), l_ch_bm, h_ch_bm

#define _TCA_BASIC(dev, div, ticks) \
    HAL_TCA_CONFIG_BASIC _(dev, _SINGLE_PER), ticks, _(dev, _SINGLE_CTRLA), div

; Value Setting
#define _TCA_PER(dev, val)         HAL_IO_WRITE2 _(dev, _SINGLE_PER), val
#define _TCA_CMP0(dev, val)        HAL_IO_WRITE2 _(dev, _SINGLE_CMP0), val
#define _TCA_CMP1(dev, val)        HAL_IO_WRITE2 _(dev, _SINGLE_CMP1), val
#define _TCA_CMP2(dev, val)        HAL_IO_WRITE2 _(dev, _SINGLE_CMP2), val

; Buffered Updates
#define _TCA_PERBUF(dev, val)      HAL_IO_WRITE2 _(dev, _SINGLE_PERBUF), val
#define _TCA_CMP0BUF(dev, val)     HAL_IO_WRITE2 _(dev, _SINGLE_CMP0BUF), val
#define _TCA_CMP1BUF(dev, val)     HAL_IO_WRITE2 _(dev, _SINGLE_CMP1BUF), val
#define _TCA_CMP2BUF(dev, val)     HAL_IO_WRITE2 _(dev, _SINGLE_CMP2BUF), val

; --- Runtime Update Functions ---

; Function: HAL_TCA0_UPDATE_PER
; Inputs: r23:r22 - New Period
FUNC HAL_TCA0_UPDATE_PER
    sts2    TCA0_SINGLE_PER, r22
ENDF HAL_TCA0_UPDATE_PER

; Function: HAL_TCA0_UPDATE_CMP0
; Inputs: r23:r22 - New Compare 0
FUNC HAL_TCA0_UPDATE_CMP0
    sts2    TCA0_SINGLE_CMP0, r22
ENDF HAL_TCA0_UPDATE_CMP0
