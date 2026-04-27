
#if defined VREF_REFSEL_VDD_gc
  .print "____ Using VREF v2"
  #define _VREF_DAC0_CONFIG(...)   HAL_VREF_CONFIG VREF_DAC0REF, ##__VA_ARGS__
  #define _VREF_ADC0_CONFIG(...)   HAL_VREF_CONFIG VREF_ADC0REF, ##__VA_ARGS__
  #define _VREF_ADC1_CONFIG(...)   HAL_VREF_CONFIG VREF_ADC1REF, ##__VA_ARGS__
  #define _VREF_AC_CONFIG(...)     HAL_VREF_CONFIG VREF_ACREF, ##__VA_ARGS__

  .macro HAL_VREF_CONFIG device, vref=0, always=0
      ldi     r16, (\vref & VREF_REFSEL_gm) | (\always & VREF_ALWAYSON_bm)
      sts     \device, r16
  .endm

#elif defined VREF_CTRLB
  .print "____ Using VREF v1"
  #define _VREF_DAC0_CONFIG(...)   HAL_VREF_CONFIG VREF_CTRLA, ##__VA_ARGS__
  #define _VREF_DAC1_CONFIG(...)   HAL_VREF_CONFIG VREF_CTRLC, ##__VA_ARGS__
  #define _VREF_DAC2_CONFIG(...)   HAL_VREF_CONFIG VREF_CTRLD, ##__VA_ARGS__
  #define _VREF_ADC0_CONFIG(...)   HAL_VREF_CONFIG VREF_CTRLA, ##__VA_ARGS__
  #define _VREF_ADC1_CONFIG(...)   HAL_VREF_CONFIG VREF_CTRLC, ##__VA_ARGS__

  .macro HAL_VREF_CONFIG control, vref=0
    ldi     r16, \vref
    sts     \control, r16
  .endm

#else
  #error "NO VREF detected"
#endif
