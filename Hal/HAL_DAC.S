
#define _DAC0_ENABLE()                HAL_DAC_ENABLE DAC0_CTRLA, ""
#define _DAC0_ENABLE_OUTPUT(options)  HAL_DAC_ENABLE DAC0_CTRLA, options
#define _DAC1_ENABLE()                HAL_DAC_ENABLE DAC1_CTRLA, ""
#define _DAC1_ENABLE_OUTPUT(options)  HAL_DAC_ENABLE DAC1_CTRLA, options
#define _DAC2_ENABLE()                HAL_DAC_ENABLE DAC2_CTRLA, ""
#define _DAC2_ENABLE_OUTPUT(options)  HAL_DAC_ENABLE DAC2_CTRLA, options

.macro HAL_DAC_ENABLE device, options=DAC_OUTEN_bm
    ldi     r16, \options | DAC_ENABLE_bm
    sts     \device, r16
.endm

#ifdef DAC0_DATAH

#define _DAC0_OUTPUT(value)           HAL_DAC_OUTPUT DAC0_DATA, value
#define _DAC0_OUTPUT_REG(reg)         sts2  DAC0_DATA, reg
.macro HAL_DAC_OUTPUT device, value=0
  ldi2    r16, (\value << 6)
  sts2    \device, r16
.endm

#else

#define _DAC0_OUTPUT(value)           HAL_DAC_OUTPUT DAC0_DATA, value
#define _DAC0_OUTPUT_REG(reg)         sts  DAC0_DATA, reg
#define _DAC1_OUTPUT(value)           HAL_DAC_OUTPUT DAC1_DATA, value
#define _DAC1_OUTPUT_REG(reg)         sts  DAC1_DATA, reg
#define _DAC2_OUTPUT(value)           HAL_DAC_OUTPUT DAC2_DATA, value
#define _DAC2_OUTPUT_REG(reg)         sts  DAC2_DATA, reg
.macro HAL_DAC_OUTPUT device, value=0
  ldi     r16, \value
  sts     \device, r16
.endm

#endif
