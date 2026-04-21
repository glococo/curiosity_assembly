
#if defined VREF_REFSEL_VDD_gc

  #define _VREF_DAC0_CONFIG(...)   HAL_VREF_CONFIG VREF_DAC0REF, __VA_ARGS__
  #define _VREF_ADC0_CONFIG(...)   HAL_VREF_CONFIG VREF_ADC0REF, __VA_ARGS__
  #define _VREF_ADC1_CONFIG(...)   HAL_VREF_CONFIG VREF_ADC1REF, __VA_ARGS__
  #define _VREF_AC_CONFIG(...)     HAL_VREF_CONFIG VREF_ACREF, __VA_ARGS__

  .macro HAL_VREF_CONFIG device, vref=0, always=0
      ldi     r16, (\vref & VREF_REFSEL_gm) | (\always & VREF_ALWAYSON_bm)
      sts     \device, r16
  .endm

#elif defined VREF_CTRLB

  #define _VREF_DAC0_CONFIG(...)   HAL_VREF_CONFIG VREF_CTRLA, __VA_ARGS__
  #define _VREF_DAC1_CONFIG(...)   HAL_VREF_CONFIG VREF_CTRLC, __VA_ARGS__
  #define _VREF_DAC2_CONFIG(...)   HAL_VREF_CONFIG VREF_CTRLD, __VA_ARGS__
  #define _VREF_ADC0_CONFIG(...)   HAL_VREF_CONFIG VREF_CTRLD, __VA_ARGS__

  .macro HAL_VREF_CONFIG control, vref=0, force=0
      ldi     r16, (\vref & 0x07)
      sts     \control, r16
      lds     r16, VREF_CTRLB
    .if     \control == VREF_CTRLA
      ori     r16, (VREF_DAC0REFEN_bm && \force)
    .elseif \control == VREF_CTRLC
      ori     r16, (VREF_DAC1REFEN_bm && \force)
    .elseif \control == VREF_CTRLD
      ori     r16, (VREF_DAC2REFEN_bm && \force)
    .else
      .error "wrong VREF CTRL"
    .endif
      sts     VREF_CTRLB, r16
  .endm

#else
  #error "NO VREF IPBlock"
#endif
