#define AC_HYSMODE_NONE_gc  (0x00<<1) /* No hysteresis */
#define AC_HYSMODE_SMALL_gc  (0x01<<1) /* Small hysteresis */
#define AC_HYSMODE_MEDIUM_gc  (0x02<<1) /* Medium hysteresis */
#define AC_HYSMODE_LARGE_gc  (0x03<<1)  /* Large hysteresis */
#define AC_INITVAL_LOW_gc  (0x00<<6) /* Output initialized to 0 */
#define AC_INITVAL_HIGH_gc  (0x01<<6)  /* Output initialized to 1 */
#define AC_INTMODE_NORMAL_BOTHEDGE_gc  (0x00<<4) /* Positive and negative inputs crosses */
#define AC_INTMODE_NORMAL_NEGEDGE_gc  (0x02<<4) /* Positive input goes below negative input */
#define AC_INTMODE_NORMAL_POSEDGE_gc  (0x03<<4)  /* Positive input goes above negative input */
#define AC_INTMODE_WINDOW_ABOVE_gc  (0x00<<4) /* Window interrupt when input above both references */
#define AC_INTMODE_WINDOW_INSIDE_gc  (0x01<<4) /* Window interrupt when input betweeen references */
#define AC_INTMODE_WINDOW_BELOW_gc  (0x02<<4) /* Window interrupt when input below both references */
#define AC_INTMODE_WINDOW_OUTSIDE_gc  (0x03<<4)  /* Window interrupt when input outside reference */
#define AC_MUXNEG_AINN0_gc  (0x00<<0) /* Negative Pin 0 */
#define AC_MUXNEG_AINN1_gc  (0x01<<0) /* Negative Pin 1 */
#define AC_MUXNEG_AINN2_gc  (0x02<<0) /* Negative Pin 2 */
#define AC_MUXNEG_AINN3_gc  (0x03<<0) /* Negative Pin 3 */
#define AC_MUXNEG_DACREF_gc  (0x04<<0)  /* DAC Reference */
#define AC_MUXPOS_AINP0_gc  (0x00<<3) /* Positive Pin 0 */
#define AC_MUXPOS_AINP1_gc  (0x01<<3) /* Positive Pin 1 */
#define AC_MUXPOS_AINP2_gc  (0x02<<3) /* Positive Pin 2 */
#define AC_MUXPOS_AINP3_gc  (0x03<<3) /* Positive Pin 3 */
#define AC_MUXPOS_AINP4_gc  (0x04<<3) /* Positive Pin 4 */
#define AC_MUXPOS_AINP5_gc  (0x05<<3) /* Positive Pin 5 */
#define AC_MUXPOS_AINP6_gc  (0x06<<3)  /* Positive Pin 6 */
#define AC_POWER_PROFILE0_gc  (0x00<<3) /* Power profile 0, Fastest response time, highest consumption */
#define AC_POWER_PROFILE1_gc  (0x01<<3)  /* Power profile 1 */
#define AC_WINSEL_DISABLED_gc  (0x00<<0) /* Window function disabled */
#define AC_WINSEL_UPSEL1_gc  (0x01<<0)  /* Select ACn+1 as upper limit in window compare */
#define AC_WINSTATE_ABOVE_gc  (0x00<<6) /* Above window */
#define AC_WINSTATE_INSIDE_gc  (0x01<<6) /* Inside window */
#define AC_WINSTATE_BELOW_gc  (0x02<<6)  /* Below window */
#define ADC_CHOPPING_DISABLE_gc  (0x00<<6) /* Sign Chopping Disabled */
#define ADC_CHOPPING_ENABLE_gc  (0x01<<6)  /* Sign Chopping Enabled */
#define ADC_GAIN_1X_gc  (0x00<<5) /* 1x gain */
#define ADC_GAIN_2X_gc  (0x01<<5) /* 2x gain */
#define ADC_GAIN_4X_gc  (0x02<<5) /* 4x gain */
#define ADC_GAIN_8X_gc  (0x03<<5) /* 8x gain */
#define ADC_GAIN_16X_gc  (0x04<<5)  /* 16x gain */
#define ADC_MODE_SINGLE_8BIT_gc  (0x00<<4) /* Single Conversion with 8-bit resolution */
#define ADC_MODE_SINGLE_12BIT_gc  (0x01<<4) /* Single Conversion with 12-bit resolution */
#define ADC_MODE_SERIES_gc  (0x02<<4) /* Series with accumulation, separate trigger for every 12-bit conversion */
#define ADC_MODE_SERIES_SCALING_gc  (0x03<<4) /* Series with accumulation and scaling, separate trigger for every 12-bit conversion */
#define ADC_MODE_BURST_gc  (0x04<<4) /* Burst with accumulation, one trigger will run SAMPNUM 12-bit conversions */
#define ADC_MODE_BURST_SCALING_gc  (0x05<<4)  /* Burst with accumulation and scaling, one trigger will run SAMPNUM 12-bit conversions */
#define ADC_MUXNEG_AIN4_gc  (0x04<<0) /* ADC input pin 4 */
#define ADC_MUXNEG_AIN5_gc  (0x05<<0) /* ADC input pin 5 */
#define ADC_MUXNEG_AIN6_gc  (0x06<<0) /* ADC input pin 6 */
#define ADC_MUXNEG_AIN7_gc  (0x07<<0) /* ADC input pin 7 */
#define ADC_MUXNEG_AIN22_gc  (0x16<<0) /* ADC input pin 22 */
#define ADC_MUXNEG_AIN23_gc  (0x17<<0) /* ADC input pin 23 */
#define ADC_MUXNEG_AIN24_gc  (0x18<<0) /* ADC input pin 24 */
#define ADC_MUXNEG_AIN25_gc  (0x19<<0) /* ADC input pin 25 */
#define ADC_MUXNEG_AIN26_gc  (0x1A<<0) /* ADC input pin 26 */
#define ADC_MUXNEG_AIN27_gc  (0x1B<<0) /* ADC input pin 27 */
#define ADC_MUXNEG_AIN28_gc  (0x1C<<0) /* ADC input pin 28 */
#define ADC_MUXNEG_AIN29_gc  (0x1D<<0) /* ADC input pin 29 */
#define ADC_MUXNEG_AIN30_gc  (0x1E<<0) /* ADC input pin 30 */
#define ADC_MUXNEG_AIN31_gc  (0x1F<<0) /* ADC input pin 31 */
#define ADC_MUXNEG_GND_gc  (0x30<<0) /* Ground */
#define ADC_MUXNEG_DAC0_gc  (0x38<<0) /* Digital to Analog Converter 0 */
#define ADC_MUXNEG_DACREF0_gc  (0x39<<0) /* AC0 DAC reference */
#define ADC_MUXNEG_DACREF1_gc  (0x3A<<0)  /* AC1 DAC reference */
#define ADC_MUXPOS_AIN4_gc  (0x04<<0) /* ADC input pin 4 */
#define ADC_MUXPOS_AIN5_gc  (0x05<<0) /* ADC input pin 5 */
#define ADC_MUXPOS_AIN6_gc  (0x06<<0) /* ADC input pin 6 */
#define ADC_MUXPOS_AIN7_gc  (0x07<<0) /* ADC input pin 7 */
#define ADC_MUXPOS_AIN22_gc  (0x16<<0) /* ADC input pin 22 */
#define ADC_MUXPOS_AIN23_gc  (0x17<<0) /* ADC input pin 23 */
#define ADC_MUXPOS_AIN24_gc  (0x18<<0) /* ADC input pin 24 */
#define ADC_MUXPOS_AIN25_gc  (0x19<<0) /* ADC input pin 25 */
#define ADC_MUXPOS_AIN26_gc  (0x1A<<0) /* ADC input pin 26 */
#define ADC_MUXPOS_AIN27_gc  (0x1B<<0) /* ADC input pin 27 */
#define ADC_MUXPOS_AIN28_gc  (0x1C<<0) /* ADC input pin 28 */
#define ADC_MUXPOS_AIN29_gc  (0x1D<<0) /* ADC input pin 29 */
#define ADC_MUXPOS_AIN30_gc  (0x1E<<0) /* ADC input pin 30 */
#define ADC_MUXPOS_AIN31_gc  (0x1F<<0) /* ADC input pin 31 */
#define ADC_MUXPOS_GND_gc  (0x30<<0) /* Ground */
#define ADC_MUXPOS_VDD10_gc  (0x31<<0) /* VDD Divided by 10 */
#define ADC_MUXPOS_TEMPSENSE_gc  (0x32<<0)  /* Temperature Sensor */
#define ADC_PGABIASSEL_100PCT_gc  (0x00<<3) /* 100% BIAS current. */
#define ADC_PGABIASSEL_75PCT_gc  (0x01<<3) /* 75% BIAS current. Usable for CLK_ADC<4.5MHz */
#define ADC_PGABIASSEL_50PCT_gc  (0x02<<3) /* 50% BIAS current. Usable for CLK_ADC<3MHz */
#define ADC_PGABIASSEL_25PCT_gc  (0x03<<3)  /* 25% BIAS current. Usable for CLK_ADC<1.5MHz */
#define ADC_PRESC_DIV2_gc  (0x00<<0) /* System clock divided by 2 */
#define ADC_PRESC_DIV4_gc  (0x01<<0) /* System clock divided by 4 */
#define ADC_PRESC_DIV6_gc  (0x02<<0) /* System clock divided by 6 */
#define ADC_PRESC_DIV8_gc  (0x03<<0) /* System clock divided by 8 */
#define ADC_PRESC_DIV10_gc  (0x04<<0) /* System clock divided by 10 */
#define ADC_PRESC_DIV12_gc  (0x05<<0) /* System clock divided by 12 */
#define ADC_PRESC_DIV14_gc  (0x06<<0) /* System clock divided by 14 */
#define ADC_PRESC_DIV16_gc  (0x07<<0) /* System clock divided by 16 */
#define ADC_PRESC_DIV20_gc  (0x08<<0) /* System clock divided by 20 */
#define ADC_PRESC_DIV24_gc  (0x09<<0) /* System clock divided by 24 */
#define ADC_PRESC_DIV28_gc  (0x0A<<0) /* System clock divided by 28 */
#define ADC_PRESC_DIV32_gc  (0x0B<<0) /* System clock divided by 32 */
#define ADC_PRESC_DIV40_gc  (0x0C<<0) /* System clock divided by 40 */
#define ADC_PRESC_DIV48_gc  (0x0D<<0) /* System clock divided by 48 */
#define ADC_PRESC_DIV56_gc  (0x0E<<0) /* System clock divided by 56 */
#define ADC_PRESC_DIV64_gc  (0x0F<<0)  /* System clock divided by 64 */
#define ADC_REFSEL_VDD_gc  (0x00<<0) /* VDD */
#define ADC_REFSEL_VREFA_gc  (0x02<<0) /* External Reference */
#define ADC_REFSEL_1V024_gc  (0x04<<0) /* Internal 1.024V Reference */
#define ADC_REFSEL_2V048_gc  (0x05<<0) /* Internal 2.048V Reference */
#define ADC_REFSEL_4V096_gc  (0x06<<0) /* Internal 4.096V Reference */
#define ADC_REFSEL_2V500_gc  (0x07<<0)  /* Internal 2.500V Reference */
#define ADC_SAMPNUM_NONE_gc  (0x00<<0) /* No accumulation */
#define ADC_SAMPNUM_ACC2_gc  (0x01<<0) /* 2 samples accumulated */
#define ADC_SAMPNUM_ACC4_gc  (0x02<<0) /* 4 samples accumulated */
#define ADC_SAMPNUM_ACC8_gc  (0x03<<0) /* 8 samples accumulated */
#define ADC_SAMPNUM_ACC16_gc  (0x04<<0) /* 16 samples accumulated */
#define ADC_SAMPNUM_ACC32_gc  (0x05<<0) /* 32 samples accumulated */
#define ADC_SAMPNUM_ACC64_gc  (0x06<<0) /* 64 samples accumulated */
#define ADC_SAMPNUM_ACC128_gc  (0x07<<0) /* 128 samples accumulated */
#define ADC_SAMPNUM_ACC256_gc  (0x08<<0) /* 256 samples accumulated */
#define ADC_SAMPNUM_ACC512_gc  (0x09<<0) /* 512 samples accumulated */
#define ADC_SAMPNUM_ACC1024_gc  (0x0A<<0)  /* 1024 samples accumulated */
#define ADC_START_STOP_gc  (0x00<<0) /* Stop an ongoing conversion */
#define ADC_START_IMMEDIATE_gc  (0x01<<0) /* Start a conversion immediately. This will be set back to STOP when the first conversion is done, unless Free-Running mode is enabled */
#define ADC_START_MUXPOS_WRITE_gc  (0x02<<0) /* Start when MUXPOS register is written */
#define ADC_START_MUXNEG_WRITE_gc  (0x03<<0) /* Start when MUXNEG register is written */
#define ADC_START_EVENT_TRIGGER_gc  (0x04<<0)  /* Start when an event is received */
#define ADC_VIA_DIRECT_gc  (0x00<<6) /* Inputs connected directly to ADC */
#define ADC_VIA_PGA_gc  (0x01<<6)  /* Inputs connected via PGA */
#define ADC_WINCM_NONE_gc  (0x00<<0) /* No Window Comparison */
#define ADC_WINCM_BELOW_gc  (0x01<<0) /* Below Window */
#define ADC_WINCM_ABOVE_gc  (0x02<<0) /* Above Window */
#define ADC_WINCM_INSIDE_gc  (0x03<<0) /* Inside Window */
#define ADC_WINCM_OUTSIDE_gc  (0x04<<0)  /* Outside Window */
#define ADC_WINSRC_RESULT_gc  (0x00<<3) /* Result register used as Window Comparator Source */
#define ADC_WINSRC_SAMPLE_gc  (0x01<<3)  /* Sample register used as Window Comparator Source */
#define BOD_ACTIVE_DISABLE_gc  (0x00<<2) /* Disabled */
#define BOD_ACTIVE_ENABLED_gc  (0x01<<2) /* Enabled in continuous mode */
#define BOD_ACTIVE_SAMPLED_gc  (0x02<<2) /* Enabled in sampled mode */
#define BOD_ACTIVE_ENABLEWAIT_gc  (0x03<<2)  /* Enabled in continuous mode. Execution halted at wake-up until BOD is running */
#define BOD_LVL_BODLEVEL0_gc  (0x00<<0) /* BOD Disabled during normal operation */
#define BOD_LVL_BODLEVEL1_gc  (0x01<<0) /* 1.9 V */
#define BOD_LVL_BODLEVEL2_gc  (0x02<<0) /* 2.7 V */
#define BOD_LVL_BODLEVEL3_gc  (0x03<<0)  /* 4.5 V */
#define BOD_SAMPFREQ_128HZ_gc  (0x00<<4) /* Sampling frequency is 128 Hz */
#define BOD_SAMPFREQ_32HZ_gc  (0x01<<4)  /* Sample frequency is 32 Hz */
#define BOD_SLEEP_DISABLE_gc  (0x00<<0) /* Disabled */
#define BOD_SLEEP_ENABLE_gc  (0x01<<0) /* Enabled in continuous mode */
#define BOD_SLEEP_SAMPLE_gc  (0x02<<0)  /* Enabled in sampled mode */
#define BOD_VLMCFG_FALLING_gc  (0x00<<1) /* VDD falls below VLM threshold */
#define BOD_VLMCFG_RISING_gc  (0x01<<1) /* VDD rises above VLM threshold */
#define BOD_VLMCFG_BOTH_gc  (0x02<<1)  /* VDD crosses VLM threshold */
#define BOD_VLMLVL_OFF_gc  (0x00<<0) /* VLM Disabled */
#define BOD_VLMLVL_5ABOVE_gc  (0x01<<0) /* VLM threshold 5% above BOD level */
#define BOD_VLMLVL_15ABOVE_gc  (0x02<<0) /* VLM threshold 15% above BOD level */
#define BOD_VLMLVL_25ABOVE_gc  (0x03<<0)  /* VLM threshold 25% above BOD level */
#define BOD_VLMS_ABOVE_gc  (0x00<<0) /* The voltage is above the VLM threshold level */
#define BOD_VLMS_BELOW_gc  (0x01<<0)  /* The voltage is below the VLM threshold level */
#define CCL_CLKSRC_CLKPER_gc  (0x00<<1) /* Peripheral Clock */
#define CCL_CLKSRC_IN2_gc  (0x01<<1) /* INSEL2 selection */
#define CCL_CLKSRC_OSCHF_gc  (0x04<<1) /* Internal High Frequency oscillator */
#define CCL_CLKSRC_OSC32K_gc  (0x05<<1) /* Internal 32.768 kHz oscillator */
#define CCL_CLKSRC_OSC1K_gc  (0x06<<1) /* Internal 32.768 kHz oscillator divided by 32 */
#define CCL_CLKSRC_PLL_gc  (0x07<<1)  /* PLL */
#define CCL_EDGEDET_DIS_gc  (0x00<<7) /* Edge detector is disabled */
#define CCL_EDGEDET_EN_gc  (0x01<<7)  /* Edge detector is enabled */
#define CCL_FILTSEL_DISABLE_gc  (0x00<<4) /* Filter disabled */
#define CCL_FILTSEL_SYNCH_gc  (0x01<<4) /* Synchronizer enabled */
#define CCL_FILTSEL_FILTER_gc  (0x02<<4)  /* Filter enabled */
#define CCL_INSEL0_MASK_gc  (0x00<<0) /* Masked input */
#define CCL_INSEL0_FEEDBACK_gc  (0x01<<0) /* Feedback input */
#define CCL_INSEL0_LINK_gc  (0x02<<0) /* Output from LUT[n+1] as input source */
#define CCL_INSEL0_EVENTA_gc  (0x03<<0) /* Event A as input source */
#define CCL_INSEL0_EVENTB_gc  (0x04<<0) /* Event B as input source */
#define CCL_INSEL0_IN0_gc  (0x05<<0) /* IN0 input source */
#define CCL_INSEL0_AC0_gc  (0x06<<0) /* AC0 output input source */
#define CCL_INSEL0_USART0_gc  (0x07<<0) /* USART0 TxD input source */
#define CCL_INSEL0_SPI0_gc  (0x08<<0) /* SPI0 MOSI input source */
#define CCL_INSEL0_TCE0_gc  (0x09<<0) /* TCE0 WO0 input source */
#define CCL_INSEL0_TCB0_gc  (0x0A<<0) /* TCB0 WO input source */
#define CCL_INSEL0_TCF0_gc  (0x0B<<0) /* TCF0 WO0 input source */
#define CCL_INSEL0_WEX0_gc  (0x0C<<0)  /* Blanking input source */
#define CCL_INSEL1_MASK_gc  (0x00<<4) /* Masked input */
#define CCL_INSEL1_FEEDBACK_gc  (0x01<<4) /* Feedback input */
#define CCL_INSEL1_LINK_gc  (0x02<<4) /* Output from LUT[n+1] as input source */
#define CCL_INSEL1_EVENTA_gc  (0x03<<4) /* Event A as input source */
#define CCL_INSEL1_EVENTB_gc  (0x04<<4) /* Event B as input source */
#define CCL_INSEL1_IN1_gc  (0x05<<4) /* IN1 input source */
#define CCL_INSEL1_AC1_gc  (0x06<<4) /* AC1 output input source */
#define CCL_INSEL1_USART0_gc  (0x07<<4) /* USART0 TxD input source */
#define CCL_INSEL1_SPI0_gc  (0x08<<4) /* SPI0 MOSI input source */
#define CCL_INSEL1_TCE0_gc  (0x09<<4) /* TCE0 WO1 input source */
#define CCL_INSEL1_TCB1_gc  (0x0A<<4) /* TCB1 WO input source */
#define CCL_INSEL1_TCF0_gc  (0x0B<<4) /* TCF0 WO1 input source */
#define CCL_INSEL1_WEX0_gc  (0x0C<<4)  /* Blanking input source */
#define CCL_INSEL2_MASK_gc  (0x00<<0) /* Masked input */
#define CCL_INSEL2_FEEDBACK_gc  (0x01<<0) /* Feedback input */
#define CCL_INSEL2_LINK_gc  (0x02<<0) /* Output from LUT[n+1] as input source */
#define CCL_INSEL2_EVENTA_gc  (0x03<<0) /* Event A as input source */
#define CCL_INSEL2_EVENTB_gc  (0x04<<0) /* Event B as input source */
#define CCL_INSEL2_IN2_gc  (0x05<<0) /* IN2 input source */
#define CCL_INSEL2_AC1_gc  (0x06<<0) /* AC1 output input source */
#define CCL_INSEL2_USART0_gc  (0x07<<0) /* USART0 TxD input source */
#define CCL_INSEL2_SPI0_gc  (0x08<<0) /* SPI0 SCK input source */
#define CCL_INSEL2_TCE0_gc  (0x09<<0) /* TCE0 WO2 input source */
#define CCL_INSEL2_TCB1_gc  (0x0A<<0) /* TCB1 WO input source */
#define CCL_INSEL2_TCF0_gc  (0x0B<<0) /* TCF0 WO0 input source */
#define CCL_INSEL2_WEX0_gc  (0x0C<<0)  /* Blanking input source */
#define CCL_INTMODE0_INTDISABLE_gc  (0x00<<0) /* Interrupt disabled */
#define CCL_INTMODE0_RISING_gc  (0x01<<0) /* Sense rising edge */
#define CCL_INTMODE0_FALLING_gc  (0x02<<0) /* Sense falling edge */
#define CCL_INTMODE0_BOTH_gc  (0x03<<0)  /* Sense both edges */
#define CCL_INTMODE1_INTDISABLE_gc  (0x00<<2) /* Interrupt disabled */
#define CCL_INTMODE1_RISING_gc  (0x01<<2) /* Sense rising edge */
#define CCL_INTMODE1_FALLING_gc  (0x02<<2) /* Sense falling edge */
#define CCL_INTMODE1_BOTH_gc  (0x03<<2)  /* Sense both edges */
#define CCL_INTMODE2_INTDISABLE_gc  (0x00<<4) /* Interrupt disabled */
#define CCL_INTMODE2_RISING_gc  (0x01<<4) /* Sense rising edge */
#define CCL_INTMODE2_FALLING_gc  (0x02<<4) /* Sense falling edge */
#define CCL_INTMODE2_BOTH_gc  (0x03<<4)  /* Sense both edges */
#define CCL_INTMODE3_INTDISABLE_gc  (0x00<<6) /* Interrupt disabled */
#define CCL_INTMODE3_RISING_gc  (0x01<<6) /* Sense rising edge */
#define CCL_INTMODE3_FALLING_gc  (0x02<<6) /* Sense falling edge */
#define CCL_INTMODE3_BOTH_gc  (0x03<<6)  /* Sense both edges */
#define CCL_SEQSEL_DISABLE_gc  (0x00<<0) /* Sequential logic disabled */
#define CCL_SEQSEL_DFF_gc  (0x01<<0) /* D FlipFlop */
#define CCL_SEQSEL_JK_gc  (0x02<<0) /* JK FlipFlop */
#define CCL_SEQSEL_LATCH_gc  (0x03<<0) /* D Latch */
#define CCL_SEQSEL_RS_gc  (0x04<<0)  /* RS Latch */
#define CLKCTRL_AUTOTUNE_OFF_gc  (0x00<<0) /* Disabled */
#define CLKCTRL_AUTOTUNE_XOSC32K_gc  (0x01<<0)  /* Tune against 32.768 kHz Crystal Oscillator */
#define CLKCTRL_CLKDIV_NONE_gc  (0x00<<0) /* PLL output clock undivided */
#define CLKCTRL_CLKDIV_DIV2_gc  (0x01<<0)  /* PLL output clock divided by 2 */
#define CLKCTRL_CLKSEL_OSCHF_gc  (0x00<<0) /* Internal high-frequency oscillator */
#define CLKCTRL_CLKSEL_OSC32K_gc  (0x01<<0) /* Internal 32.768 kHz oscillator */
#define CLKCTRL_CLKSEL_XOSC32K_gc  (0x02<<0) /* 32.768 kHz crystal oscillator */
#define CLKCTRL_CLKSEL_EXTCLK_gc  (0x03<<0) /* External clock */
#define CLKCTRL_CLKSEL_PLL_gc  (0x04<<0)  /* PLL Oscillator */
#define CLKCTRL_CSUT_1K_gc  (0x00<<4) /* 1k cycles */
#define CLKCTRL_CSUT_16K_gc  (0x01<<4) /* 16k cycles */
#define CLKCTRL_CSUT_32K_gc  (0x02<<4) /* 32k cycles */
#define CLKCTRL_CSUT_64K_gc  (0x03<<4)  /* 64k cycles */
#define CLKCTRL_MULFAC_OFF_gc  (0x00<<0) /* PLL Disabled */
#define CLKCTRL_MULFAC_8X_gc  (0x02<<0) /* Multiply by 8 */
#define CLKCTRL_MULFAC_16X_gc  (0x03<<0)  /* Multiply by 16 */
#define CLKCTRL_PBDIV_NONE_gc  (0x00<<5) /* No division */
#define CLKCTRL_PBDIV_DIV4_gc  (0x01<<5)  /* Divide by 4 */
#define CLKCTRL_PDIV_DIV2_gc  (0x00<<1) /* Divide by 2 */
#define CLKCTRL_PDIV_DIV4_gc  (0x01<<1) /* Divide by 4 */
#define CLKCTRL_PDIV_DIV8_gc  (0x02<<1) /* Divide by 8 */
#define CLKCTRL_PDIV_DIV16_gc  (0x03<<1) /* Divide by 16 */
#define CLKCTRL_PDIV_DIV32_gc  (0x04<<1) /* Divide by 32 */
#define CLKCTRL_PDIV_DIV64_gc  (0x05<<1) /* Divide by 64 */
#define CLKCTRL_PDIV_DIV6_gc  (0x08<<1) /* Divide by 6 */
#define CLKCTRL_PDIV_DIV10_gc  (0x09<<1) /* Divide by 10 */
#define CLKCTRL_PDIV_DIV12_gc  (0x0A<<1) /* Divide by 12 */
#define CLKCTRL_PDIV_DIV24_gc  (0x0B<<1) /* Divide by 24 */
#define CLKCTRL_PDIV_DIV48_gc  (0x0C<<1)  /* Divide by 48 */
#define CLKCTRL_SOURCE_OSCHF_gc  (0x00<<5) /* Internal High Frequency Oscillator */
#define CLKCTRL_SOURCE_EXTCLK_gc  (0x01<<5)  /* External Clock */
#define CLKCTRL_SOURCEDIV_DIV1_gc  (0x00<<3) /* Source undivided */
#define CLKCTRL_SOURCEDIV_DIV2_gc  (0x01<<3) /* Divide source by 2 */
#define CLKCTRL_SOURCEDIV_DIV4_gc  (0x02<<3) /* Divide source by 4 */
#define CLKCTRL_SOURCEDIV_DIV6_gc  (0x03<<3)  /* Divide source by 6 */
#define CCP_SPM_gc  (0x9D<<0) /* SPM Instruction Protection */
#define CCP_IOREG_gc  (0xD8<<0)  /* IO Register Protection */
#define CRCSCAN_SRC_FLASH_gc  (0x00<<0) /* CRC on entire flash */
#define CRCSCAN_SRC_APPLICATION_gc  (0x01<<0) /* CRC on boot and appl section of flash */
#define CRCSCAN_SRC_BOOT_gc  (0x02<<0)  /* CRC on boot section of flash */
#define EVSYS_CHANNEL_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_CHANNEL_UPDI_SYNCH_gc  (0x01<<0) /* UPDI SYNCH character */
#define EVSYS_CHANNEL_RTC_OVF_gc  (0x06<<0) /* Real Time Counter overflow */
#define EVSYS_CHANNEL_RTC_CMP_gc  (0x07<<0) /* Real Time Counter compare */
#define EVSYS_CHANNEL_RTC_PITEV0_gc  (0x08<<0) /* Periodic Interrupt Timer Event 0 */
#define EVSYS_CHANNEL_RTC_PITEV1_gc  (0x09<<0) /* Periodic Interrupt Timer Event 1 */
#define EVSYS_CHANNEL_CCL_LUT0_gc  (0x10<<0) /* Configurable Custom Logic LUT0 */
#define EVSYS_CHANNEL_CCL_LUT1_gc  (0x11<<0) /* Configurable Custom Logic LUT1 */
#define EVSYS_CHANNEL_CCL_LUT2_gc  (0x12<<0) /* Configurable Custom Logic LUT2 */
#define EVSYS_CHANNEL_CCL_LUT3_gc  (0x13<<0) /* Configurable Custom Logic LUT3 */
#define EVSYS_CHANNEL_AC0_OUT_gc  (0x20<<0) /* Analog Comparator 0 out */
#define EVSYS_CHANNEL_AC1_OUT_gc  (0x21<<0) /* Analog Comparator 1 out */
#define EVSYS_CHANNEL_ADC0_RES_gc  (0x24<<0) /* ADC 0 Result Ready */
#define EVSYS_CHANNEL_ADC0_SAMP_gc  (0x25<<0) /* ADC 0 Sample Ready */
#define EVSYS_CHANNEL_ADC0_WCMP_gc  (0x26<<0) /* ADC 0 Window Compare */
#define EVSYS_CHANNEL_PORTA_EV0_gc  (0x40<<0) /* Port A Event 0 */
#define EVSYS_CHANNEL_PORTA_EV1_gc  (0x41<<0) /* Port A Event 1 */
#define EVSYS_CHANNEL_PORTC_EV0_gc  (0x44<<0) /* Port C Event 0 */
#define EVSYS_CHANNEL_PORTC_EV1_gc  (0x45<<0) /* Port C Event 1 */
#define EVSYS_CHANNEL_PORTD_EV0_gc  (0x46<<0) /* Port D Event 0 */
#define EVSYS_CHANNEL_PORTD_EV1_gc  (0x47<<0) /* Port D Event 1 */
#define EVSYS_CHANNEL_PORTF_EV0_gc  (0x4A<<0) /* Port F Event 0 */
#define EVSYS_CHANNEL_PORTF_EV1_gc  (0x4B<<0) /* Port F Event 1 */
#define EVSYS_CHANNEL_USART0_XCK_gc  (0x60<<0) /* USART 0 XCK */
#define EVSYS_CHANNEL_SPI0_SCK_gc  (0x68<<0) /* SPI 0 SCK */
#define EVSYS_CHANNEL_TCE0_OVF_gc  (0x80<<0) /* Timer/Counter E0 overflow */
#define EVSYS_CHANNEL_TCE0_CMP0_gc  (0x84<<0) /* Timer/Counter E0 compare 0 */
#define EVSYS_CHANNEL_TCE0_CMP1_gc  (0x85<<0) /* Timer/Counter E0 compare 1 */
#define EVSYS_CHANNEL_TCE0_CMP2_gc  (0x86<<0) /* Timer/Counter E0 compare 2 */
#define EVSYS_CHANNEL_TCE0_CMP3_gc  (0x87<<0) /* Timer/Counter E0 compare 3 */
#define EVSYS_CHANNEL_TCB0_CAPT_gc  (0xA0<<0) /* Timer/Counter B0 capture */
#define EVSYS_CHANNEL_TCB0_OVF_gc  (0xA1<<0) /* Timer/Counter B0 overflow */
#define EVSYS_CHANNEL_TCB1_CAPT_gc  (0xA2<<0) /* Timer/Counter B1 capture */
#define EVSYS_CHANNEL_TCB1_OVF_gc  (0xA3<<0) /* Timer/Counter B1 overflow */
#define EVSYS_CHANNEL_TCF0_OVF_gc  (0xB8<<0) /* Timer/Counter F0 Overflow */
#define EVSYS_CHANNEL_TCF0_CMP0_gc  (0xB9<<0) /* Timer/Counter F0 compare 0 */
#define EVSYS_CHANNEL_TCF0_CMP1_gc  (0xBA<<0)  /* Timer/Counter F0 compare 1 */
#define EVSYS_SWEVENTA_CH0_gc  (0x01<<0) /* Software event on channel 0 */
#define EVSYS_SWEVENTA_CH1_gc  (0x02<<0) /* Software event on channel 1 */
#define EVSYS_SWEVENTA_CH2_gc  (0x04<<0) /* Software event on channel 2 */
#define EVSYS_SWEVENTA_CH3_gc  (0x08<<0) /* Software event on channel 3 */
#define EVSYS_SWEVENTA_CH4_gc  (0x10<<0) /* Software event on channel 4 */
#define EVSYS_SWEVENTA_CH5_gc  (0x20<<0) /* Software event on channel 5 */
#define EVSYS_SWEVENTA_CH6_gc  (0x40<<0) /* Software event on channel 6 */
#define EVSYS_SWEVENTA_CH7_gc  (0x80<<0)  /* Software event on channel 7 */
#define EVSYS_USER_OFF_gc  (0x00<<0) /* Off, No Eventsys Channel connected */
#define EVSYS_USER_CHANNEL0_gc  (0x01<<0) /* Connect user to event channel 0 */
#define EVSYS_USER_CHANNEL1_gc  (0x02<<0) /* Connect user to event channel 1 */
#define EVSYS_USER_CHANNEL2_gc  (0x03<<0) /* Connect user to event channel 2 */
#define EVSYS_USER_CHANNEL3_gc  (0x04<<0) /* Connect user to event channel 3 */
#define EVSYS_USER_CHANNEL4_gc  (0x05<<0) /* Connect user to event channel 4 */
#define EVSYS_USER_CHANNEL5_gc  (0x06<<0)  /* Connect user to event channel 5 */
#define ACTIVE_DISABLE_gc  (0x00<<2) /* Disabled */
#define ACTIVE_ENABLED_gc  (0x01<<2) /* Enabled in continuous mode */
#define ACTIVE_SAMPLED_gc  (0x02<<2) /* Enabled in sampled mode */
#define ACTIVE_ENABLEWAIT_gc  (0x03<<2)  /* Enabled in continuous mode. Execution halted at wake-up until BOD is running */
#define CRCSEL_CRC16_gc  (0x00<<5) /* Enable CRC16 */
#define CRCSEL_CRC32_gc  (0x01<<5)  /* Enable CRC32 */
#define CRCSRC_FLASH_gc  (0x00<<6) /* CRC of full Flash (boot, application code and application data) */
#define CRCSRC_BOOT_gc  (0x01<<6) /* CRC of boot section */
#define CRCSRC_BOOTAPP_gc  (0x02<<6) /* CRC of application code and boot sections */
#define CRCSRC_NOCRC_gc  (0x03<<6)  /* No CRC */
#define EESAVE_DISABLE_gc  (0x00<<0) /* EEPROM content is erased during chip erase */
#define EESAVE_ENABLE_gc  (0x01<<0)  /* EEPROM content is preserved during chip erase */
#define KEY_NOTACT_gc  (0x00<<4) /* Not Active */
#define KEY_NVMACT_gc  (0xB45<<4)  /* NVM Protection Active */
#define LEVEL_NVMACCDIS_gc  (0x02<<0) /* NVM Access through UPDI disabled */
#define LEVEL_BASIC_gc  (0x03<<0)  /* UPDI and UPDI pins working normally */
#define LVL_BODLEVEL0_gc  (0x00<<5) /* BOD Disabled during normal operation */
#define LVL_BODLEVEL1_gc  (0x01<<5) /* 1.9 V */
#define LVL_BODLEVEL2_gc  (0x02<<5) /* 2.7 V */
#define LVL_BODLEVEL3_gc  (0x03<<5)  /* 4.5 V */
#define OSCHFFRQ_20M_gc  (0x00<<3) /* OSCHF running at 20 MHz */
#define OSCHFFRQ_16M_gc  (0x01<<3)  /* OSCHF running at 16 MHz */
#define PERIOD_OFF_gc  (0x00<<0) /* Watch-Dog timer Off */
#define PERIOD_8CLK_gc  (0x01<<0) /* 8 cycles (8ms) */
#define PERIOD_16CLK_gc  (0x02<<0) /* 16 cycles (16ms) */
#define PERIOD_32CLK_gc  (0x03<<0) /* 32 cycles (32ms) */
#define PERIOD_64CLK_gc  (0x04<<0) /* 64 cycles (64ms) */
#define PERIOD_128CLK_gc  (0x05<<0) /* 128 cycles (0.128s) */
#define PERIOD_256CLK_gc  (0x06<<0) /* 256 cycles (0.256s) */
#define PERIOD_512CLK_gc  (0x07<<0) /* 512 cycles (0.512s) */
#define PERIOD_1KCLK_gc  (0x08<<0) /* 1K cycles (1.0s) */
#define PERIOD_2KCLK_gc  (0x09<<0) /* 2K cycles (2.0s) */
#define PERIOD_4KCLK_gc  (0x0A<<0) /* 4K cycles (4.0s) */
#define PERIOD_8KCLK_gc  (0x0B<<0)  /* 8K cycles (8.0s) */
#define RSTPINCFG_NONE_gc  (0x00<<3) /* No External Reset */
#define RSTPINCFG_RESET_gc  (0x01<<3)  /* PF6 configured as RESET pin */
#define SAMPFREQ_128HZ_gc  (0x00<<4) /* Sampling frequency is 128 Hz */
#define SAMPFREQ_32HZ_gc  (0x01<<4)  /* Sample frequency is 32 Hz */
#define SLEEP_DISABLE_gc  (0x00<<0) /* Disabled */
#define SLEEP_ENABLE_gc  (0x01<<0) /* Enabled in continuous mode */
#define SLEEP_SAMPLE_gc  (0x02<<0)  /* Enabled in sampled mode */
#define SUT_0MS_gc  (0x00<<0) /* 0 ms */
#define SUT_1MS_gc  (0x01<<0) /* 1 ms */
#define SUT_2MS_gc  (0x02<<0) /* 2 ms */
#define SUT_4MS_gc  (0x03<<0) /* 4 ms */
#define SUT_8MS_gc  (0x04<<0) /* 8 ms */
#define SUT_16MS_gc  (0x05<<0) /* 16 ms */
#define SUT_32MS_gc  (0x06<<0) /* 32 ms */
#define SUT_64MS_gc  (0x07<<0)  /* 64 ms */
#define UPDIPINCFG_GPIO_gc  (0x00<<4) /* PF7 Configured as GPIO pin */
#define UPDIPINCFG_UPDI_gc  (0x01<<4)  /* PF7 Configured as UPDI pin */
#define WINDOW_OFF_gc  (0x00<<4) /* Window mode off */
#define WINDOW_8CLK_gc  (0x01<<4) /* 8 cycles (8ms) */
#define WINDOW_16CLK_gc  (0x02<<4) /* 16 cycles (16ms) */
#define WINDOW_32CLK_gc  (0x03<<4) /* 32 cycles (32ms) */
#define WINDOW_64CLK_gc  (0x04<<4) /* 64 cycles (64ms) */
#define WINDOW_128CLK_gc  (0x05<<4) /* 128 cycles (0.128s) */
#define WINDOW_256CLK_gc  (0x06<<4) /* 256 cycles (0.256s) */
#define WINDOW_512CLK_gc  (0x07<<4) /* 512 cycles (0.512s) */
#define WINDOW_1KCLK_gc  (0x08<<4) /* 1K cycles (1.0s) */
#define WINDOW_2KCLK_gc  (0x09<<4) /* 2K cycles (2.0s) */
#define WINDOW_4KCLK_gc  (0x0A<<4) /* 4K cycles (4.0s) */
#define WINDOW_8KCLK_gc  (0x0B<<4)  /* 8K cycles (8.0s) */
#define LOCK_KEY_NOLOCK_gc  (0x5CC5C55C<<0) /* No locks */
#define LOCK_KEY_RWLOCK_gc  (0xA33A3AA3<<0)  /* Read and write lock */
#define NVMCTRL_CMD_NOCMD_gc  (0x00<<0) /* No Command */
#define NVMCTRL_CMD_NOOP_gc  (0x01<<0) /* No Operation */
#define NVMCTRL_CMD_FLPW_gc  (0x04<<0) /* Flash Page Write */
#define NVMCTRL_CMD_FLPERW_gc  (0x05<<0) /* Flash Page Erase and Write */
#define NVMCTRL_CMD_FLPER_gc  (0x08<<0) /* Flash Page Erase */
#define NVMCTRL_CMD_FLMPER2_gc  (0x09<<0) /* Flash 2-page erase enable */
#define NVMCTRL_CMD_FLMPER4_gc  (0x0A<<0) /* Flash 4-page erase enable */
#define NVMCTRL_CMD_FLMPER8_gc  (0x0B<<0) /* Flash 8-page erase enable */
#define NVMCTRL_CMD_FLMPER16_gc  (0x0C<<0) /* Flash 16-page erase enable */
#define NVMCTRL_CMD_FLMPER32_gc  (0x0D<<0) /* Flash 32-page erase enable */
#define NVMCTRL_CMD_FLPBCLR_gc  (0x0F<<0) /* Flash Page Buffer Clear */
#define NVMCTRL_CMD_EEPW_gc  (0x14<<0) /* EEPROM Page Write */
#define NVMCTRL_CMD_EEPERW_gc  (0x15<<0) /* EEPROM Page Erase and Write */
#define NVMCTRL_CMD_EEPER_gc  (0x17<<0) /* EEPROM Page Erase */
#define NVMCTRL_CMD_EEPBCLR_gc  (0x1F<<0) /* EEPROM Page Buffer Clear */
#define NVMCTRL_CMD_CHER_gc  (0x20<<0) /* Chip Erase Command (UPDI only) */
#define NVMCTRL_CMD_EECHER_gc  (0x30<<0)  /* EEPROM Erase Command (UPDI only) */
#define NVMCTRL_ERROR_NOERROR_gc  (0x00<<4) /* No Error */
#define NVMCTRL_ERROR_WRITEPROTECT_gc  (0x02<<4) /* Attempt to program write protected area */
#define NVMCTRL_ERROR_CMDCOLLISION_gc  (0x03<<4) /* Selecting new write command while write command already seleted */
#define NVMCTRL_ERROR_WRONGSECTION_gc  (0x04<<4)  /* Address cannot be written with selected command */
#define NVMCTRL_FLMAP_SECTION0_gc  (0x00<<4) /* Flash section 0, 0 - 32KB */
#define NVMCTRL_FLMAP_SECTION1_gc  (0x01<<4) /* Flash section 1, 32 - 64KB */
#define NVMCTRL_FLMAP_SECTION2_gc  (0x02<<4) /* Flash section 2, 64 - 96KB */
#define NVMCTRL_FLMAP_SECTION3_gc  (0x03<<4)  /* Flash section 3, 96 - 128KB */
#define PORT_EVGEN0SEL_PIN0_gc  (0x00<<0) /* Pin 0 used as event generator */
#define PORT_EVGEN0SEL_PIN1_gc  (0x01<<0) /* Pin 1 used as event generator */
#define PORT_EVGEN0SEL_PIN2_gc  (0x02<<0) /* Pin 2 used as event generator */
#define PORT_EVGEN0SEL_PIN3_gc  (0x03<<0) /* Pin 3 used as event generator */
#define PORT_EVGEN0SEL_PIN4_gc  (0x04<<0) /* Pin 4 used as event generator */
#define PORT_EVGEN0SEL_PIN5_gc  (0x05<<0) /* Pin 5 used as event generator */
#define PORT_EVGEN0SEL_PIN6_gc  (0x06<<0) /* Pin 6 used as event generator */
#define PORT_EVGEN0SEL_PIN7_gc  (0x07<<0)  /* Pin 7 used as event generator */
#define PORT_EVGEN1SEL_PIN0_gc  (0x00<<4) /* Pin 0 used as event generator */
#define PORT_EVGEN1SEL_PIN1_gc  (0x01<<4) /* Pin 1 used as event generator */
#define PORT_EVGEN1SEL_PIN2_gc  (0x02<<4) /* Pin 2 used as event generator */
#define PORT_EVGEN1SEL_PIN3_gc  (0x03<<4) /* Pin 3 used as event generator */
#define PORT_EVGEN1SEL_PIN4_gc  (0x04<<4) /* Pin 4 used as event generator */
#define PORT_EVGEN1SEL_PIN5_gc  (0x05<<4) /* Pin 5 used as event generator */
#define PORT_EVGEN1SEL_PIN6_gc  (0x06<<4) /* Pin 6 used as event generator */
#define PORT_EVGEN1SEL_PIN7_gc  (0x07<<4)  /* Pin 7 used as event generator */
#define PORT_INLVL_ST_gc  (0x00<<6) /* Schmitt-Trigger input level */
#define PORT_INLVL_TTL_gc  (0x01<<6)  /* TTL Input level */
#define PORT_ISC_INTDISABLE_gc  (0x00<<0) /* Interrupt disabled but input buffer enabled */
#define PORT_ISC_BOTHEDGES_gc  (0x01<<0) /* Sense Both Edges */
#define PORT_ISC_RISING_gc  (0x02<<0) /* Sense Rising Edge */
#define PORT_ISC_FALLING_gc  (0x03<<0) /* Sense Falling Edge */
#define PORT_ISC_INPUT_DISABLE_gc  (0x04<<0) /* Digital Input Buffer disabled */
#define PORT_ISC_LEVEL_gc  (0x05<<0)  /* Sense low Level */
#define PORTMUX_AC0_DEFAULT_gc  (0x00<<0)  /* OUT: PA7 */
#define PORTMUX_AC1_DEFAULT_gc  (0x00<<1)  /* OUT: PA7 */
#define PORTMUX_EVOUTA_DEFAULT_gc  (0x00<<0) /* EVOUTA: PA2 */
#define PORTMUX_EVOUTA_ALT1_gc  (0x01<<0)  /* EVOUTA: PA7 */
#define PORTMUX_EVOUTC_DEFAULT_gc  (0x00<<2)  /* EVOUTC: PC2 */
#define PORTMUX_EVOUTD_DEFAULT_gc  (0x00<<3) /* Not connected to any pins */
#define PORTMUX_EVOUTD_ALT1_gc  (0x01<<3)  /* EVOUTD: PD7 */
#define PORTMUX_EVOUTF_DEFAULT_gc  (0x00<<5) /* Not connected to any pins */
#define PORTMUX_EVOUTF_ALT1_gc  (0x01<<5)  /* EVOUTF: PF7 */
#define PORTMUX_LUT0_DEFAULT_gc  (0x00<<0) /* Out: PA3 In: PA0, PA1, PA2 */
#define PORTMUX_LUT0_ALT1_gc  (0x01<<0)  /* Out: PA6 In: PA0, PA1, PA2 */
#define PORTMUX_LUT1_DEFAULT_gc  (0x00<<1) /* Out: PC3 In: PC0, PC1, PC2 */
#define PORTMUX_LUT1_ALT1_gc  (0x01<<1)  /* Out: - In: PC0, PC1, PC2 */
#define PORTMUX_LUT2_DEFAULT_gc  (0x00<<2) /* Not connected to any pins */
#define PORTMUX_LUT2_ALT1_gc  (0x01<<2)  /* Out: PD6 In: -, -, - */
#define PORTMUX_SPI0_DEFAULT_gc  (0x00<<0) /* MOSI: PA4, MISO: PA5, SCK: PA6, SS: PA7 */
#define PORTMUX_SPI0_ALT3_gc  (0x03<<0) /* MOSI: PA0, MISO: PA1, SCK: PC0, SS: PC1 */
#define PORTMUX_SPI0_ALT4_gc  (0x04<<0) /* MOSI: PD4, MISO: PD5, SCK: PD6, SS: PD7 */
#define PORTMUX_SPI0_ALT5_gc  (0x05<<0) /* MOSI: PC0, MISO: PC1, SCK: PC2, SS: PC3 */
#define PORTMUX_SPI0_ALT6_gc  (0x06<<0) /* MOSI: PC1, MISO: PC2, SCK: PC3, SS: PF7 */
#define PORTMUX_SPI0_NONE_gc  (0x07<<0)  /* Not connected to any pins, SS set to 1 */
#define PORTMUX_TCB0_DEFAULT_gc  (0x00<<0)  /* WO: PA2 */
#define PORTMUX_TCB1_DEFAULT_gc  (0x00<<1)  /* WO: PA3 */
#define PORTMUX_TCE0_PORTA_gc  (0x00<<0) /* WOn: PA0, PA1, PA2, PA3, PA4, PA5, PA6, PA7 */
#define PORTMUX_TCE0_PORTC_gc  (0x02<<0) /* WOn: PC0, PC1, PC2, PC3, -, -, -, - */
#define PORTMUX_TCE0_PORTD_gc  (0x03<<0) /* WOn: -, -, -, -, PD4, PD5, PD6, PD7 */
#define PORTMUX_TCE0_PORTC2_gc  (0x08<<0) /* WOn: PA0, PA1, PC0, PC1, PC2, PC3, -, - */
#define PORTMUX_TCE0_PORTA2_gc  (0x09<<0)  /* WOn: PA2, PA3, PA4, PA5, PA6, PA7, -, - */
#define PORTMUX_TCF0_DEFAULT_gc  (0x00<<0) /* WOn: PA0, PA1 */
#define PORTMUX_TCF0_ALT1_gc  (0x01<<0)  /* WOn: PA6, PA7 */
#define PORTMUX_TWI0_DEFAULT_gc  (0x00<<0) /* SDA: PA2, SCL: PA3. Dual mode: SDA: PC2, SCL: PC3 */
#define PORTMUX_TWI0_ALT1_gc  (0x01<<0) /* SDA: PA2, SCL: PA3. Dual mode: SDA: -, SCL: - */
#define PORTMUX_TWI0_ALT2_gc  (0x02<<0) /* SDA: PC2, SCL: PC3. Dual mode: SDA: -, SCL: - */
#define PORTMUX_TWI0_ALT3_gc  (0x03<<0)  /* SDA: PA0, SCL: PA1. Dual mode: SDA: PC2, SCL: PC3 */
#define PORTMUX_USART0_DEFAULT_gc  (0x00<<0) /* TxD: PA0, RxD: PA1, XCK: PA2, XDIR: PA3 */
#define PORTMUX_USART0_ALT1_gc  (0x01<<0) /* TxD: PA4, RxD: PA5, XCK: PA6, XDIR: PA7 */
#define PORTMUX_USART0_ALT2_gc  (0x02<<0) /* TxD: PA2, RxD: PA3, XCK: -, XDIR: - */
#define PORTMUX_USART0_ALT3_gc  (0x03<<0) /* TxD: PD4, RxD: PD5, XCK: PD6, XDIR: PD7 */
#define PORTMUX_USART0_ALT4_gc  (0x04<<0) /* TxD: PC1, RxD: PC2, XCK: PC3, XDIR: - */
#define PORTMUX_USART0_ALT6_gc  (0x06<<0) /* TxD: PF7, RxD: PF6, XCK: -, XDIR: - */
#define PORTMUX_USART0_NONE_gc  (0x07<<0)  /* Not connected to any pins */
#define RTC_CLKSEL_OSC32K_gc  (0x00<<0) /* Internal 32.768 kHz Oscillator */
#define RTC_CLKSEL_OSC1K_gc  (0x01<<0) /* Internal 32.768 kHz Oscillator Divided by 32 */
#define RTC_CLKSEL_XOSC32K_gc  (0x02<<0) /* 32.768 kHz Crystal Oscillator */
#define RTC_CLKSEL_EXTCLK_gc  (0x03<<0)  /* External Clock */
#define RTC_EVGEN0SEL_OFF_gc  (0x00<<0) /* No Event Generated */
#define RTC_EVGEN0SEL_DIV4_gc  (0x01<<0) /* CLK_RTC divided by 4 */
#define RTC_EVGEN0SEL_DIV8_gc  (0x02<<0) /* CLK_RTC divided by 8 */
#define RTC_EVGEN0SEL_DIV16_gc  (0x03<<0) /* CLK_RTC divided by 16 */
#define RTC_EVGEN0SEL_DIV32_gc  (0x04<<0) /* CLK_RTC divided by 32 */
#define RTC_EVGEN0SEL_DIV64_gc  (0x05<<0) /* CLK_RTC divided by 64 */
#define RTC_EVGEN0SEL_DIV128_gc  (0x06<<0) /* CLK_RTC divided by 128 */
#define RTC_EVGEN0SEL_DIV256_gc  (0x07<<0) /* CLK_RTC divided by 256 */
#define RTC_EVGEN0SEL_DIV512_gc  (0x08<<0) /* CLK_RTC divided by 512 */
#define RTC_EVGEN0SEL_DIV1024_gc  (0x09<<0) /* CLK_RTC divided by 1024 */
#define RTC_EVGEN0SEL_DIV2048_gc  (0x0A<<0) /* CLK_RTC divided by 2048 */
#define RTC_EVGEN0SEL_DIV4096_gc  (0x0B<<0) /* CLK_RTC divided by 4096 */
#define RTC_EVGEN0SEL_DIV8192_gc  (0x0C<<0) /* CLK_RTC divided by 8192 */
#define RTC_EVGEN0SEL_DIV16384_gc  (0x0D<<0) /* CLK_RTC divided by 16384 */
#define RTC_EVGEN0SEL_DIV32768_gc  (0x0E<<0)  /* CLK_RTC divided by 32768 */
#define RTC_EVGEN1SEL_OFF_gc  (0x00<<4) /* No Event Generated */
#define RTC_EVGEN1SEL_DIV4_gc  (0x01<<4) /* CLK_RTC divided by 4 */
#define RTC_EVGEN1SEL_DIV8_gc  (0x02<<4) /* CLK_RTC divided by 8 */
#define RTC_EVGEN1SEL_DIV16_gc  (0x03<<4) /* CLK_RTC divided by 16 */
#define RTC_EVGEN1SEL_DIV32_gc  (0x04<<4) /* CLK_RTC divided by 32 */
#define RTC_EVGEN1SEL_DIV64_gc  (0x05<<4) /* CLK_RTC divided by 64 */
#define RTC_EVGEN1SEL_DIV128_gc  (0x06<<4) /* CLK_RTC divided by 128 */
#define RTC_EVGEN1SEL_DIV256_gc  (0x07<<4) /* CLK_RTC divided by 256 */
#define RTC_EVGEN1SEL_DIV512_gc  (0x08<<4) /* CLK_RTC divided by 512 */
#define RTC_EVGEN1SEL_DIV1024_gc  (0x09<<4) /* CLK_RTC divided by 1024 */
#define RTC_EVGEN1SEL_DIV2048_gc  (0x0A<<4) /* CLK_RTC divided by 2048 */
#define RTC_EVGEN1SEL_DIV4096_gc  (0x0B<<4) /* CLK_RTC divided by 4096 */
#define RTC_EVGEN1SEL_DIV8192_gc  (0x0C<<4) /* CLK_RTC divided by 8192 */
#define RTC_EVGEN1SEL_DIV16384_gc  (0x0D<<4) /* CLK_RTC divided by 16384 */
#define RTC_EVGEN1SEL_DIV32768_gc  (0x0E<<4)  /* CLK_RTC divided by 32768 */
#define RTC_PERIOD_OFF_gc  (0x00<<3) /* Off */
#define RTC_PERIOD_CYC4_gc  (0x01<<3) /* RTC Clock Cycles 4 */
#define RTC_PERIOD_CYC8_gc  (0x02<<3) /* RTC Clock Cycles 8 */
#define RTC_PERIOD_CYC16_gc  (0x03<<3) /* RTC Clock Cycles 16 */
#define RTC_PERIOD_CYC32_gc  (0x04<<3) /* RTC Clock Cycles 32 */
#define RTC_PERIOD_CYC64_gc  (0x05<<3) /* RTC Clock Cycles 64 */
#define RTC_PERIOD_CYC128_gc  (0x06<<3) /* RTC Clock Cycles 128 */
#define RTC_PERIOD_CYC256_gc  (0x07<<3) /* RTC Clock Cycles 256 */
#define RTC_PERIOD_CYC512_gc  (0x08<<3) /* RTC Clock Cycles 512 */
#define RTC_PERIOD_CYC1024_gc  (0x09<<3) /* RTC Clock Cycles 1024 */
#define RTC_PERIOD_CYC2048_gc  (0x0A<<3) /* RTC Clock Cycles 2048 */
#define RTC_PERIOD_CYC4096_gc  (0x0B<<3) /* RTC Clock Cycles 4096 */
#define RTC_PERIOD_CYC8192_gc  (0x0C<<3) /* RTC Clock Cycles 8192 */
#define RTC_PERIOD_CYC16384_gc  (0x0D<<3) /* RTC Clock Cycles 16384 */
#define RTC_PERIOD_CYC32768_gc  (0x0E<<3)  /* RTC Clock Cycles 32768 */
#define RTC_PRESCALER_DIV1_gc  (0x00<<3) /* RTC Clock / 1 */
#define RTC_PRESCALER_DIV2_gc  (0x01<<3) /* RTC Clock / 2 */
#define RTC_PRESCALER_DIV4_gc  (0x02<<3) /* RTC Clock / 4 */
#define RTC_PRESCALER_DIV8_gc  (0x03<<3) /* RTC Clock / 8 */
#define RTC_PRESCALER_DIV16_gc  (0x04<<3) /* RTC Clock / 16 */
#define RTC_PRESCALER_DIV32_gc  (0x05<<3) /* RTC Clock / 32 */
#define RTC_PRESCALER_DIV64_gc  (0x06<<3) /* RTC Clock / 64 */
#define RTC_PRESCALER_DIV128_gc  (0x07<<3) /* RTC Clock / 128 */
#define RTC_PRESCALER_DIV256_gc  (0x08<<3) /* RTC Clock / 256 */
#define RTC_PRESCALER_DIV512_gc  (0x09<<3) /* RTC Clock / 512 */
#define RTC_PRESCALER_DIV1024_gc  (0x0A<<3) /* RTC Clock / 1024 */
#define RTC_PRESCALER_DIV2048_gc  (0x0B<<3) /* RTC Clock / 2048 */
#define RTC_PRESCALER_DIV4096_gc  (0x0C<<3) /* RTC Clock / 4096 */
#define RTC_PRESCALER_DIV8192_gc  (0x0D<<3) /* RTC Clock / 8192 */
#define RTC_PRESCALER_DIV16384_gc  (0x0E<<3) /* RTC Clock / 16384 */
#define RTC_PRESCALER_DIV32768_gc  (0x0F<<3)  /* RTC Clock / 32768 */
#define SLPCTRL_SMODE_IDLE_gc  (0x00<<1) /* Idle mode */
#define SLPCTRL_SMODE_STDBY_gc  (0x01<<1) /* Standby Mode */
#define SLPCTRL_SMODE_PDOWN_gc  (0x02<<1)  /* Power-down Mode */
#define SPI_MODE_0_gc  (0x00<<0) /* SPI Mode 0 */
#define SPI_MODE_1_gc  (0x01<<0) /* SPI Mode 1 */
#define SPI_MODE_2_gc  (0x02<<0) /* SPI Mode 2 */
#define SPI_MODE_3_gc  (0x03<<0)  /* SPI Mode 3 */
#define SPI_PRESC_DIV4_gc  (0x00<<1) /* CLK_PER / 4 */
#define SPI_PRESC_DIV16_gc  (0x01<<1) /* CLK_PER / 16 */
#define SPI_PRESC_DIV64_gc  (0x02<<1) /* CLK_PER / 64 */
#define SPI_PRESC_DIV128_gc  (0x03<<1)  /* CLK_PER / 128 */
#define TCB_CLKSEL_DIV1_gc  (0x00<<1) /* CLK_PER */
#define TCB_CLKSEL_DIV2_gc  (0x01<<1) /* CLK_PER/2 */
#define TCB_CLKSEL_TCE0_gc  (0x02<<1) /* Use CLK_TCE from TCE0 */
#define TCB_CLKSEL_EVENT_gc  (0x07<<1)  /* Count on event edge */
#define TCB_CNTMODE_INT_gc  (0x00<<0) /* Periodic Interrupt */
#define TCB_CNTMODE_TIMEOUT_gc  (0x01<<0) /* Periodic Timeout */
#define TCB_CNTMODE_CAPT_gc  (0x02<<0) /* Input Capture Event */
#define TCB_CNTMODE_FRQ_gc  (0x03<<0) /* Input Capture Frequency measurement */
#define TCB_CNTMODE_PW_gc  (0x04<<0) /* Input Capture Pulse-Width measurement */
#define TCB_CNTMODE_FRQPW_gc  (0x05<<0) /* Input Capture Frequency and Pulse-Width measurement */
#define TCB_CNTMODE_SINGLE_gc  (0x06<<0) /* Single Shot */
#define TCB_CNTMODE_PWM8_gc  (0x07<<0)  /* 8-bit PWM */
#define TCB_CNTSIZE_16BITS_gc  (0x00<<0) /* 16-bit CNT. MAX=16'hFFFF */
#define TCB_CNTSIZE_15BITS_gc  (0x01<<0) /* 15-bit CNT. MAX=16'h7FFF */
#define TCB_CNTSIZE_14BITS_gc  (0x02<<0) /* 14-bit CNT. MAX=16'h3FFF */
#define TCB_CNTSIZE_13BITS_gc  (0x03<<0) /* 13-bit CNT. MAX=16'h1FFF */
#define TCB_CNTSIZE_12BITS_gc  (0x04<<0) /* 12-bit CNT. MAX=16'h0FFF */
#define TCB_CNTSIZE_11BITS_gc  (0x05<<0) /* 11-bit CNT. MAX=16'h07FF */
#define TCB_CNTSIZE_10BITS_gc  (0x06<<0) /* 10-bit CNT. MAX=16'h03FF */
#define TCB_CNTSIZE_9BITS_gc  (0x07<<0)  /* 9-bit CNT. MAX=16'h01FF */
#define TCB_EVGEN_PULSE_gc  (0x00<<7) /* Event is generated as pulse at compare match or capture */
#define TCB_EVGEN_WAVEFORM_gc  (0x01<<7)  /* Event is generated as waveform for modes with waveform */
#define TCE_CLKSEL_DIV1_gc  (0x00<<1) /* System Clock */
#define TCE_CLKSEL_DIV2_gc  (0x01<<1) /* System Clock / 2 */
#define TCE_CLKSEL_DIV4_gc  (0x02<<1) /* System Clock / 4 */
#define TCE_CLKSEL_DIV8_gc  (0x03<<1) /* System Clock / 8 */
#define TCE_CLKSEL_DIV16_gc  (0x04<<1) /* System Clock / 16 */
#define TCE_CLKSEL_DIV64_gc  (0x05<<1) /* System Clock / 64 */
#define TCE_CLKSEL_DIV256_gc  (0x06<<1) /* System Clock / 256 */
#define TCE_CLKSEL_DIV1024_gc  (0x07<<1)  /* System Clock / 1024 */
#define TCE_CMD_NONE_gc  (0x00<<2) /* No Command */
#define TCE_CMD_UPDATE_gc  (0x01<<2) /* Force Update */
#define TCE_CMD_RESTART_gc  (0x02<<2) /* Force Restart */
#define TCE_CMD_RESET_gc  (0x03<<2)  /* Force Hard Reset */
#define TCE_CMP0EV_PULSE_gc  (0x00<<4) /* Event output for CMP is a pulse */
#define TCE_CMP0EV_WAVEFORM_gc  (0x01<<4)  /* Event output for CMP is equal to waveform */
#define TCE_CMP1EV_PULSE_gc  (0x00<<5) /* Event output for CMP is a pulse */
#define TCE_CMP1EV_WAVEFORM_gc  (0x01<<5)  /* Event output for CMP is equal to waveform */
#define TCE_CMP2EV_PULSE_gc  (0x00<<6) /* Event output for CMP is a pulse */
#define TCE_CMP2EV_WAVEFORM_gc  (0x01<<6)  /* Event output for CMP is equal to waveform */
#define TCE_CMP3EV_PULSE_gc  (0x00<<7) /* Event output for CMP is a pulse */
#define TCE_CMP3EV_WAVEFORM_gc  (0x01<<7)  /* Event output for CMP is equal to waveform */
#define TCE_DIR_UP_gc  (0x00<<0) /* Count up */
#define TCE_DIR_DOWN_gc  (0x01<<0)  /* Count down */
#define TCE_EVACTA_CNT_POSEDGE_gc  (0x00<<1) /* Count on positive edge event */
#define TCE_EVACTA_CNT_ANYEDGE_gc  (0x01<<1) /* Count on any edge event */
#define TCE_EVACTA_CNT_HIGHLVL_gc  (0x02<<1) /* Count on prescaled clock while event line is 1. */
#define TCE_EVACTA_UPDOWN_gc  (0x03<<1)  /* Count on prescaled clock. Event controls count direction. Up-count when event line is 0, down-count when event line is 1. */
#define TCE_EVACTB_NONE_gc  (0x00<<5) /* No Action */
#define TCE_EVACTB_UPDOWN_gc  (0x03<<5) /* Count on prescaled clock. Event controls count direction. Up-count when event line is 0, down-count when event line is 1. */
#define TCE_EVACTB_RESTART_POSEDGE_gc  (0x04<<5) /* Restart counter at positive edge event */
#define TCE_EVACTB_RESTART_ANYEDGE_gc  (0x05<<5) /* Restart counter on any edge event */
#define TCE_EVACTB_RESTART_HIGHLVL_gc  (0x06<<5)  /* Restart counter while event line is 1. */
#define TCE_HREN_OFF_gc  (0x00<<6) /* High Resolution Disable */
#define TCE_HREN_4X_gc  (0x01<<6) /* Resolution increased by 4 (2 bits) */
#define TCE_HREN_8X_gc  (0x02<<6)  /* Resolution increased by 4 (3 bits) */
#define TCE_SCALE_NORMAL_gc  (0x00<<2) /* Absolute values used when writing to CMPn, CMPnBUF and registers */
#define TCE_SCALE_FRACTIONAL_gc  (0x01<<2)  /* Fractional values used when writing to CMPn, CMPnBUF and registers */
#define TCE_SCALEMODE_CENTER_gc  (0x00<<4) /* CMPn registers scaled vs center (50% duty cycle) */
#define TCE_SCALEMODE_BOTTOM_gc  (0x01<<4) /* CMPn registers scaled vs BOTTOM (0% duty cycle) */
#define TCE_SCALEMODE_TOP_gc  (0x02<<4) /* CMPn registers scaled vs TOP (100% duty cycle) */
#define TCE_SCALEMODE_TOPBOTTOM_gc  (0x03<<4)  /* CMPn registers scaled vs TOP or BOTTOM depending on written value. */
#define TCE_WGMODE_NORMAL_gc  (0x00<<0) /* Normal Mode */
#define TCE_WGMODE_FRQ_gc  (0x01<<0) /* Frequency Generation Mode */
#define TCE_WGMODE_SINGLESLOPE_gc  (0x03<<0) /* Single Slope PWM */
#define TCE_WGMODE_DSTOP_gc  (0x05<<0) /* Dual Slope PWM, overflow on TOP */
#define TCE_WGMODE_DSBOTH_gc  (0x06<<0) /* Dual Slope PWM, overflow on TOP and BOTTOM */
#define TCE_WGMODE_DSBOTTOM_gc  (0x07<<0)  /* Dual Slope PWM, overflow on BOTTOM */
#define TCF_CLKSEL_CLKPER_gc  (0x00<<3) /* Peripheral Clock */
#define TCF_CLKSEL_EVENT_gc  (0x01<<3) /* Event as clock source */
#define TCF_CLKSEL_OSCHF_gc  (0x02<<3) /* Internal High Frequency Oscillator */
#define TCF_CLKSEL_OSC32K_gc  (0x03<<3) /* Internal 32.768 kHz Oscillator */
#define TCF_CLKSEL_PLL_gc  (0x05<<3)  /* PLL */
#define TCF_CMD_NONE_gc  (0x00<<0) /* No command */
#define TCF_CMD_UPDATE_gc  (0x01<<0) /* Force update */
#define TCF_CMD_RESTART_gc  (0x02<<0)  /* Force restart */
#define TCF_CMP0EV_PULSE_gc  (0x00<<6) /* Event is generated as pulse */
#define TCF_CMP0EV_WAVEFORM_gc  (0x01<<6)  /* Waveform is used as event output */
#define TCF_CMP1EV_PULSE_gc  (0x00<<7) /* Event is generated as pulse */
#define TCF_CMP1EV_WAVEFORM_gc  (0x01<<7)  /* Waveform is used as event output */
#define TCF_EVACTA_RESTART_gc  (0x00<<1) /* Restart Counter */
#define TCF_EVACTA_BLANK_gc  (0x01<<1)  /* Mask waveform output to '0' */
#define TCF_PRESC_DIV1_gc  (0x00<<1) /* Runs directly on Clock Source */
#define TCF_PRESC_DIV2_gc  (0x01<<1) /* Divide clock source by 2 */
#define TCF_PRESC_DIV4_gc  (0x02<<1) /* Divide clock source by 4 */
#define TCF_PRESC_DIV8_gc  (0x03<<1) /* Divide clock source by 8 */
#define TCF_PRESC_DIV16_gc  (0x04<<1) /* Divide clock source by 16 */
#define TCF_PRESC_DIV32_gc  (0x05<<1) /* Divide clock source by 32 */
#define TCF_PRESC_DIV64_gc  (0x06<<1) /* Divide clock source by 64 */
#define TCF_PRESC_DIV128_gc  (0x07<<1)  /* Divide clock source by 128 */
#define TCF_WGMODE_FRQ_gc  (0x00<<0) /* Frequency */
#define TCF_WGMODE_NCOPF_gc  (0x01<<0) /* Numerically Controlled Oscillator Pulse-Frequency */
#define TCF_WGMODE_NCOFDC_gc  (0x02<<0) /* Numerically Controlled Oscillator Fixed Duty Cycle */
#define TCF_WGMODE_PWM8_gc  (0x07<<0)  /* 8-bit PWM */
#define TCF_WGPULSE_CLK1_gc  (0x00<<4) /* High pulse duration is 1 clock period */
#define TCF_WGPULSE_CLK2_gc  (0x01<<4) /* High pulse duration is 2 clock period */
#define TCF_WGPULSE_CLK4_gc  (0x02<<4) /* High pulse duration is 4 clock period */
#define TCF_WGPULSE_CLK8_gc  (0x03<<4) /* High pulse duration is 8 clock period */
#define TCF_WGPULSE_CLK16_gc  (0x04<<4) /* High pulse duration is 16 clock period */
#define TCF_WGPULSE_CLK32_gc  (0x05<<4) /* High pulse duration is 32 clock period */
#define TCF_WGPULSE_CLK64_gc  (0x06<<4) /* High pulse duration is 64 clock period */
#define TCF_WGPULSE_CLK128_gc  (0x07<<4)  /* High pulse duration is 128 clock period */
#define TCF_WO0POL_NORMAL_gc  (0x00<<2) /* Waveform output set on update and cleared on match */
#define TCF_WO0POL_INVERSE_gc  (0x01<<2)  /* Waveform output cleared on update and set on match */
#define TCF_WO1POL_NORMAL_gc  (0x00<<3) /* Waveform output set on update and cleared on match */
#define TCF_WO1POL_INVERSE_gc  (0x01<<3)  /* Waveform output cleared on update and set on match */
#define TWI_ACKACT_ACK_gc  (0x00<<2) /* Send ACK */
#define TWI_ACKACT_NACK_gc  (0x01<<2)  /* Send NACK */
#define TWI_AP_STOP_gc  (0x00<<0) /* A Stop condition generated the interrupt on APIF flag */
#define TWI_AP_ADR_gc  (0x01<<0)  /* Address detection generated the interrupt on APIF flag */
#define TWI_BUSSTATE_UNKNOWN_gc  (0x00<<0) /* Unknown bus state */
#define TWI_BUSSTATE_IDLE_gc  (0x01<<0) /* Bus is idle */
#define TWI_BUSSTATE_OWNER_gc  (0x02<<0) /* This TWI controls the bus */
#define TWI_BUSSTATE_BUSY_gc  (0x03<<0)  /* The bus is busy */
#define TWI_DBGRUN_HALT_gc  (0x00<<0) /* The peripheral is halted in Break Debug mode and ignores events */
#define TWI_DBGRUN_RUN_gc  (0x01<<0)  /* The peripheral will continue to run in Break Debug mode when the CPU is halted */
#define TWI_FMEN_OFF_gc  (0x00<<0) /* SCL duty cycle operating according to Sm specification */
#define TWI_FMEN_ON_gc  (0x01<<0)  /* SCL duty cycle operating according to Fm specification */
#define TWI_FMPEN_OFF_gc  (0x00<<1) /* Operating in Standard-mode or Fast-mode */
#define TWI_FMPEN_ON_gc  (0x01<<1)  /* Operating in Fast-mode Plus */
#define TWI_INPUTLVL_I2C_gc  (0x00<<6) /* I2C input voltage transition level */
#define TWI_INPUTLVL_SMBUS_gc  (0x01<<6)  /* SMBus 3.0 input voltage transition level */
#define TWI_MCMD_NOACT_gc  (0x00<<0) /* No action */
#define TWI_MCMD_REPSTART_gc  (0x01<<0) /* Execute Acknowledge Action followed by repeated Start. */
#define TWI_MCMD_RECVTRANS_gc  (0x02<<0) /* Execute Acknowledge Action followed by a byte read/write operation. Read/write is defined by DIR. */
#define TWI_MCMD_STOP_gc  (0x03<<0)  /* Execute Acknowledge Action followed by issuing a Stop condition. */
#define TWI_SCMD_NOACT_gc  (0x00<<0) /* No Action */
#define TWI_SCMD_COMPTRANS_gc  (0x02<<0) /* Complete transaction */
#define TWI_SCMD_RESPONSE_gc  (0x03<<0)  /* Used in response to an interrupt */
#define TWI_SDAHOLD_OFF_gc  (0x00<<2) /* No SDA Hold Delay */
#define TWI_SDAHOLD_50NS_gc  (0x01<<2) /* Short SDA hold time */
#define TWI_SDAHOLD_300NS_gc  (0x02<<2) /* Meets SMBUS 2.0 specification under typical conditions */
#define TWI_SDAHOLD_500NS_gc  (0x03<<2)  /* Meets SMBUS 2.0 specificaiton across all corners */
#define TWI_SDASETUP_4CYC_gc  (0x00<<4) /* SDA setup time is four clock cycles */
#define TWI_SDASETUP_8CYC_gc  (0x01<<4)  /* SDA setup time is eight clock cycle */
#define TWI_TIMEOUT_DISABLED_gc  (0x00<<2) /* Bus time-out disabled. I2C. */
#define TWI_TIMEOUT_50US_gc  (0x01<<2) /* 50us - SMBus */
#define TWI_TIMEOUT_100US_gc  (0x02<<2) /* 100us */
#define TWI_TIMEOUT_200US_gc  (0x03<<2)  /* 200us */
#define USART_ABW_WDW0_gc  (0x00<<6) /* 18% tolerance */
#define USART_ABW_WDW1_gc  (0x01<<6) /* 15% tolerance */
#define USART_ABW_WDW2_gc  (0x02<<6) /* 21% tolerance */
#define USART_ABW_WDW3_gc  (0x03<<6)  /* 25% tolerance */
#define USART_CHSIZE_5BIT_gc  (0x00<<0) /* Character size: 5 bit */
#define USART_CHSIZE_6BIT_gc  (0x01<<0) /* Character size: 6 bit */
#define USART_CHSIZE_7BIT_gc  (0x02<<0) /* Character size: 7 bit */
#define USART_CHSIZE_8BIT_gc  (0x03<<0) /* Character size: 8 bit */
#define USART_CHSIZE_9BITL_gc  (0x06<<0) /* Character size: 9 bit read low byte first */
#define USART_CHSIZE_9BITH_gc  (0x07<<0)  /* Character size: 9 bit read high byte first */
#define USART_CMODE_ASYNCHRONOUS_gc  (0x00<<6) /* Asynchronous Mode */
#define USART_CMODE_SYNCHRONOUS_gc  (0x01<<6) /* Synchronous Mode */
#define USART_CMODE_IRCOM_gc  (0x02<<6) /* Infrared Communication */
#define USART_CMODE_MSPI_gc  (0x03<<6)  /* SPI Host Mode */
#define USART_PMODE_DISABLED_gc  (0x00<<4) /* No Parity */
#define USART_PMODE_EVEN_gc  (0x02<<4) /* Even Parity */
#define USART_PMODE_ODD_gc  (0x03<<4)  /* Odd Parity */
#define USART_RS485_DISABLE_gc  (0x00<<0) /* RS485 Mode disabled */
#define USART_RS485_ENABLE_gc  (0x01<<0)  /* RS485 Mode enabled */
#define USART_RXMODE_NORMAL_gc  (0x00<<1) /* Normal mode */
#define USART_RXMODE_CLK2X_gc  (0x01<<1) /* CLK2x mode */
#define USART_RXMODE_GENAUTO_gc  (0x02<<1) /* Generic autobaud mode */
#define USART_RXMODE_LINAUTO_gc  (0x03<<1)  /* LIN constrained autobaud mode */
#define USART_SBMODE_1BIT_gc  (0x00<<3) /* 1 stop bit */
#define USART_SBMODE_2BIT_gc  (0x01<<3)  /* 2 stop bits */
#define VREF_REFSEL_1V024_gc  (0x00<<0) /* Internal 1.024V reference */
#define VREF_REFSEL_2V048_gc  (0x01<<0) /* Internal 2.048V reference */
#define VREF_REFSEL_4V096_gc  (0x02<<0) /* Internal 4.096V reference */
#define VREF_REFSEL_2V500_gc  (0x03<<0) /* Internal 2.500V reference */
#define VREF_REFSEL_VDD_gc  (0x05<<0) /* VDD as reference */
#define VREF_REFSEL_VREFA_gc  (0x06<<0)  /* External reference on VREFA pin */
#define WDT_PERIOD_OFF_gc  (0x00<<0) /* Off */
#define WDT_PERIOD_8CLK_gc  (0x01<<0) /* 8 cycles (8ms) */
#define WDT_PERIOD_16CLK_gc  (0x02<<0) /* 16 cycles (16ms) */
#define WDT_PERIOD_32CLK_gc  (0x03<<0) /* 32 cycles (32ms) */
#define WDT_PERIOD_64CLK_gc  (0x04<<0) /* 64 cycles (64ms) */
#define WDT_PERIOD_128CLK_gc  (0x05<<0) /* 128 cycles (0.128s) */
#define WDT_PERIOD_256CLK_gc  (0x06<<0) /* 256 cycles (0.256s) */
#define WDT_PERIOD_512CLK_gc  (0x07<<0) /* 512 cycles (0.512s) */
#define WDT_PERIOD_1KCLK_gc  (0x08<<0) /* 1K cycles (1.0s) */
#define WDT_PERIOD_2KCLK_gc  (0x09<<0) /* 2K cycles (2.0s) */
#define WDT_PERIOD_4KCLK_gc  (0x0A<<0) /* 4K cycles (4.1s) */
#define WDT_PERIOD_8KCLK_gc  (0x0B<<0)  /* 8K cycles (8.2s) */
#define WDT_WINDOW_OFF_gc  (0x00<<4) /* Off */
#define WDT_WINDOW_8CLK_gc  (0x01<<4) /* 8 cycles (8ms) */
#define WDT_WINDOW_16CLK_gc  (0x02<<4) /* 16 cycles (16ms) */
#define WDT_WINDOW_32CLK_gc  (0x03<<4) /* 32 cycles (32ms) */
#define WDT_WINDOW_64CLK_gc  (0x04<<4) /* 64 cycles (64ms) */
#define WDT_WINDOW_128CLK_gc  (0x05<<4) /* 128 cycles (0.128s) */
#define WDT_WINDOW_256CLK_gc  (0x06<<4) /* 256 cycles (0.256s) */
#define WDT_WINDOW_512CLK_gc  (0x07<<4) /* 512 cycles (0.512s) */
#define WDT_WINDOW_1KCLK_gc  (0x08<<4) /* 1K cycles (1.0s) */
#define WDT_WINDOW_2KCLK_gc  (0x09<<4) /* 2K cycles (2.0s) */
#define WDT_WINDOW_4KCLK_gc  (0x0A<<4) /* 4K cycles (4.1s) */
#define WDT_WINDOW_8KCLK_gc  (0x0B<<4)  /* 8K cycles (8.2s) */
#define WEX_BLANKPRESC_DIV1_gc  (0x00<<5) /* No prescaling */
#define WEX_BLANKPRESC_DIV4_gc  (0x01<<5) /* Divide CLK_PER by 4 */
#define WEX_BLANKPRESC_DIV16_gc  (0x02<<5) /* Divide CLK_PER by 16 */
#define WEX_BLANKPRESC_DIV64_gc  (0x03<<5)  /* Divide CLK_PER by 64 */
#define WEX_BLANKSTATE_OFF_gc  (0x00<<7) /* Blanking off */
#define WEX_BLANKSTATE_ON_gc  (0x01<<7)  /* Blanking active */
#define WEX_BLANKTRIG_NONE_gc  (0x00<<0) /* No HW trigger (Software only) */
#define WEX_BLANKTRIG_TCE0UPD_gc  (0x04<<0) /* TCE0 Update Condition */
#define WEX_BLANKTRIG_TCE0CMP0_gc  (0x08<<0) /* TCE0 Compare 0 */
#define WEX_BLANKTRIG_TCE0CMP1_gc  (0x0C<<0) /* TCE0 Compare 1 */
#define WEX_BLANKTRIG_TCE0CMP2_gc  (0x10<<0) /* TCE0 Compare 2 */
#define WEX_BLANKTRIG_TCE0CMP3_gc  (0x14<<0)  /* TCE0 Compare 3 */
#define WEX_CMD_NONE_gc  (0x00<<0) /* No Command */
#define WEX_CMD_UPDATE_gc  (0x01<<0) /* Force update of Dead-time, SWAP and PGM buffer registers. */
#define WEX_CMD_FAULTSET_gc  (0x02<<0) /* Set Fault Detection */
#define WEX_CMD_FAULTCLR_gc  (0x03<<0) /* Clear Fault Detection */
#define WEX_CMD_BLANKSET_gc  (0x04<<0) /* Set SW Blanking */
#define WEX_CMD_BLANKCLR_gc  (0x05<<0)  /* Clear SW Blanking */
#define WEX_FDACT_NONE_gc  (0x00<<0) /* None. Fault Protection Disabled */
#define WEX_FDACT_LOW_gc  (0x01<<0) /* Drive all pins low */
#define WEX_FDACT_CUSTOM_gc  (0x03<<0)  /* Drive all pins to setting defined by FAULTDRV and FAULTVAL */
#define WEX_FDDBD_FAULT_gc  (0x00<<7) /* OCD Break request is treated as a fault if fault protection is enabled */
#define WEX_FDDBD_IGNORE_gc  (0x01<<7)  /* OCD Breask request will not trigger a fault */
#define WEX_FDMODE_LATCHED_gc  (0x00<<2) /* Latched Mode. Output will remain in fault state until fault condition is no longer active and FDF is cleared by SW. */
#define WEX_FDMODE_CBC_gc  (0x01<<2)  /* Cycle-by-cycle mode. Waveform output will remain in fault state until fault condition is no longer active. */
#define WEX_FDSTATE_NORMAL_gc  (0x00<<0) /* Normal state */
#define WEX_FDSTATE_FAULT_gc  (0x01<<0)  /* Fault state */
#define WEX_FILTER_ZERO_gc  (0x00<<2) /* No digital filter */
#define WEX_FILTER_SAMPLE1_gc  (0x01<<2) /* One Sample */
#define WEX_FILTER_SAMPLE2_gc  (0x02<<2) /* Two Samples */
#define WEX_FILTER_SAMPLE3_gc  (0x03<<2) /* Three Samples */
#define WEX_FILTER_SAMPLE4_gc  (0x04<<2) /* Four Samples */
#define WEX_FILTER_SAMPLE5_gc  (0x05<<2) /* Five Samples */
#define WEX_FILTER_SAMPLE6_gc  (0x06<<2) /* Six Samples */
#define WEX_FILTER_SAMPLE7_gc  (0x07<<2)  /* Seven Samples */
#define WEX_INMX_DIRECT_gc  (0x00<<4) /* Direct from TCE0 */
#define WEX_INMX_CWCMA_gc  (0x02<<4) /* Common Waveform Channel Mode A. Single WO */
#define WEX_INMX_CWCMB_gc  (0x03<<4)  /* Common Waveform Channel Mode B. WO from two PWM channels */
#define WEX_UPDSRC_TCPWM0_gc  (0x00<<0) /* Timer/Counter for PWM 0 update condition */
#define WEX_UPDSRC_SW_gc  (0x03<<0)  /* Software update only. No hardware update condition */
