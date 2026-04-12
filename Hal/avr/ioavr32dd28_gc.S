#define AC_HYSMODE_NONE_gc  (0x00<<1) /* No hysteresis */
#define AC_HYSMODE_SMALL_gc  (0x01<<1) /* Small hysteresis */
#define AC_HYSMODE_MEDIUM_gc  (0x02<<1) /* Medium hysteresis */
#define AC_HYSMODE_LARGE_gc  (0x03<<1)  /* Large hysteresis */
#define AC_INITVAL_LOW_gc  (0x00<<6) /* Output initialized to 0 */
#define AC_INITVAL_HIGH_gc  (0x01<<6)  /* Output initialized to 1 */
#define AC_INTMODE_BOTHEDGE_gc  (0x00<<4) /* Positive and negative inputs crosses */
#define AC_INTMODE_NEGEDGE_gc  (0x02<<4) /* Positive input goes below negative input */
#define AC_INTMODE_POSEDGE_gc  (0x03<<4)  /* Positive input goes above negative input */
#define AC_MUXNEG_AINN0_gc  (0x00<<0) /* Negative Pin 0 */
#define AC_MUXNEG_AINN2_gc  (0x02<<0) /* Negative Pin 2 */
#define AC_MUXNEG_AINN3_gc  (0x03<<0) /* Negative Pin 3 */
#define AC_MUXNEG_DACREF_gc  (0x04<<0)  /* DAC Reference */
#define AC_MUXPOS_AINP0_gc  (0x00<<3) /* Positive Pin 0 */
#define AC_MUXPOS_AINP3_gc  (0x03<<3) /* Positive Pin 3 */
#define AC_MUXPOS_AINP4_gc  (0x04<<3)  /* Positive Pin 4 */
#define AC_POWER_PROFILE0_gc  (0x00<<3) /* Power profile 0, Shortest response time, highest consumption */
#define AC_POWER_PROFILE1_gc  (0x01<<3) /* Power profile 1 */
#define AC_POWER_PROFILE2_gc  (0x02<<3) /* Power profile 2 */
#define AC_POWER_PROFILE3_gc  (0x03<<3)  /* Power profile 3 */
#define ADC_CONVMODE_SINGLEENDED_gc  (0x00<<5) /* Single-Ended mode */
#define ADC_CONVMODE_DIFF_gc  (0x01<<5)  /* Differential mode */
#define ADC_INITDLY_DLY0_gc  (0x00<<5) /* Delay 0 CLK_ADC cycles */
#define ADC_INITDLY_DLY16_gc  (0x01<<5) /* Delay 16 CLK_ADC cycles */
#define ADC_INITDLY_DLY32_gc  (0x02<<5) /* Delay 32 CLK_ADC cycles */
#define ADC_INITDLY_DLY64_gc  (0x03<<5) /* Delay 64 CLK_ADC cycles */
#define ADC_INITDLY_DLY128_gc  (0x04<<5) /* Delay 128 CLK_ADC cycles */
#define ADC_INITDLY_DLY256_gc  (0x05<<5)  /* Delay 256 CLK_ADC cycles */
#define ADC_MUXNEG_AIN1_gc  (0x01<<0) /* ADC input pin 1 */
#define ADC_MUXNEG_AIN2_gc  (0x02<<0) /* ADC input pin 2 */
#define ADC_MUXNEG_AIN3_gc  (0x03<<0) /* ADC input pin 3 */
#define ADC_MUXNEG_AIN4_gc  (0x04<<0) /* ADC input pin 4 */
#define ADC_MUXNEG_AIN5_gc  (0x05<<0) /* ADC input pin 5 */
#define ADC_MUXNEG_AIN6_gc  (0x06<<0) /* ADC input pin 6 */
#define ADC_MUXNEG_AIN7_gc  (0x07<<0) /* ADC input pin 7 */
#define ADC_MUXNEG_AIN16_gc  (0x10<<0) /* ADC input pin 16 */
#define ADC_MUXNEG_AIN17_gc  (0x11<<0) /* ADC input pin 17 */
#define ADC_MUXNEG_AIN18_gc  (0x12<<0) /* ADC input pin 18 */
#define ADC_MUXNEG_AIN19_gc  (0x13<<0) /* ADC input pin 19 */
#define ADC_MUXNEG_AIN20_gc  (0x14<<0) /* ADC input pin 20 */
#define ADC_MUXNEG_AIN21_gc  (0x15<<0) /* ADC input pin 21 */
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
#define ADC_MUXNEG_GND_gc  (0x40<<0) /* Ground */
#define ADC_MUXNEG_DAC0_gc  (0x48<<0)  /* DAC0 */
#define ADC_MUXPOS_AIN1_gc  (0x01<<0) /* ADC input pin 1 */
#define ADC_MUXPOS_AIN2_gc  (0x02<<0) /* ADC input pin 2 */
#define ADC_MUXPOS_AIN3_gc  (0x03<<0) /* ADC input pin 3 */
#define ADC_MUXPOS_AIN4_gc  (0x04<<0) /* ADC input pin 4 */
#define ADC_MUXPOS_AIN5_gc  (0x05<<0) /* ADC input pin 5 */
#define ADC_MUXPOS_AIN6_gc  (0x06<<0) /* ADC input pin 6 */
#define ADC_MUXPOS_AIN7_gc  (0x07<<0) /* ADC input pin 7 */
#define ADC_MUXPOS_AIN16_gc  (0x10<<0) /* ADC input pin 16 */
#define ADC_MUXPOS_AIN17_gc  (0x11<<0) /* ADC input pin 17 */
#define ADC_MUXPOS_AIN18_gc  (0x12<<0) /* ADC input pin 18 */
#define ADC_MUXPOS_AIN19_gc  (0x13<<0) /* ADC input pin 19 */
#define ADC_MUXPOS_AIN20_gc  (0x14<<0) /* ADC input pin 20 */
#define ADC_MUXPOS_AIN21_gc  (0x15<<0) /* ADC input pin 21 */
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
#define ADC_MUXPOS_GND_gc  (0x40<<0) /* Ground */
#define ADC_MUXPOS_TEMPSENSE_gc  (0x42<<0) /* Temperature sensor */
#define ADC_MUXPOS_VDDDIV10_gc  (0x44<<0) /* VDD/10 */
#define ADC_MUXPOS_VDDIO2DIV10_gc  (0x45<<0) /* VDDIO2/10 */
#define ADC_MUXPOS_DAC0_gc  (0x48<<0) /* DAC0 */
#define ADC_MUXPOS_DACREF0_gc  (0x49<<0)  /* DACREF0 */
#define ADC_PRESC_DIV2_gc  (0x00<<0) /* CLK_PER divided by 2 */
#define ADC_PRESC_DIV4_gc  (0x01<<0) /* CLK_PER divided by 4 */
#define ADC_PRESC_DIV8_gc  (0x02<<0) /* CLK_PER divided by 8 */
#define ADC_PRESC_DIV12_gc  (0x03<<0) /* CLK_PER divided by 12 */
#define ADC_PRESC_DIV16_gc  (0x04<<0) /* CLK_PER divided by 16 */
#define ADC_PRESC_DIV20_gc  (0x05<<0) /* CLK_PER divided by 20 */
#define ADC_PRESC_DIV24_gc  (0x06<<0) /* CLK_PER divided by 24 */
#define ADC_PRESC_DIV28_gc  (0x07<<0) /* CLK_PER divided by 28 */
#define ADC_PRESC_DIV32_gc  (0x08<<0) /* CLK_PER divided by 32 */
#define ADC_PRESC_DIV48_gc  (0x09<<0) /* CLK_PER divided by 48 */
#define ADC_PRESC_DIV64_gc  (0x0A<<0) /* CLK_PER divided by 64 */
#define ADC_PRESC_DIV96_gc  (0x0B<<0) /* CLK_PER divided by 96 */
#define ADC_PRESC_DIV128_gc  (0x0C<<0) /* CLK_PER divided by 128 */
#define ADC_PRESC_DIV256_gc  (0x0D<<0)  /* CLK_PER divided by 256 */
#define ADC_RESSEL_12BIT_gc  (0x00<<2) /* 12-bit mode */
#define ADC_RESSEL_10BIT_gc  (0x01<<2)  /* 10-bit mode */
#define ADC_SAMPDLY_DLY0_gc  (0x00<<0) /* Delay 0 CLK_ADC cycles */
#define ADC_SAMPDLY_DLY1_gc  (0x01<<0) /* Delay 1 CLK_ADC cycles */
#define ADC_SAMPDLY_DLY2_gc  (0x02<<0) /* Delay 2 CLK_ADC cycles */
#define ADC_SAMPDLY_DLY3_gc  (0x03<<0) /* Delay 3 CLK_ADC cycles */
#define ADC_SAMPDLY_DLY4_gc  (0x04<<0) /* Delay 4 CLK_ADC cycles */
#define ADC_SAMPDLY_DLY5_gc  (0x05<<0) /* Delay 5 CLK_ADC cycles */
#define ADC_SAMPDLY_DLY6_gc  (0x06<<0) /* Delay 6 CLK_ADC cycles */
#define ADC_SAMPDLY_DLY7_gc  (0x07<<0) /* Delay 7 CLK_ADC cycles */
#define ADC_SAMPDLY_DLY8_gc  (0x08<<0) /* Delay 8 CLK_ADC cycles */
#define ADC_SAMPDLY_DLY9_gc  (0x09<<0) /* Delay 9 CLK_ADC cycles */
#define ADC_SAMPDLY_DLY10_gc  (0x0A<<0) /* Delay 10 CLK_ADC cycles */
#define ADC_SAMPDLY_DLY11_gc  (0x0B<<0) /* Delay 11 CLK_ADC cycles */
#define ADC_SAMPDLY_DLY12_gc  (0x0C<<0) /* Delay 12 CLK_ADC cycles */
#define ADC_SAMPDLY_DLY13_gc  (0x0D<<0) /* Delay 13 CLK_ADC cycles */
#define ADC_SAMPDLY_DLY14_gc  (0x0E<<0) /* Delay 14 CLK_ADC cycles */
#define ADC_SAMPDLY_DLY15_gc  (0x0F<<0)  /* Delay 15 CLK_ADC cycles */
#define ADC_SAMPNUM_NONE_gc  (0x00<<0) /* No accumulation */
#define ADC_SAMPNUM_ACC2_gc  (0x01<<0) /* 2 results accumulated */
#define ADC_SAMPNUM_ACC4_gc  (0x02<<0) /* 4 results accumulated */
#define ADC_SAMPNUM_ACC8_gc  (0x03<<0) /* 8 results accumulated */
#define ADC_SAMPNUM_ACC16_gc  (0x04<<0) /* 16 results accumulated */
#define ADC_SAMPNUM_ACC32_gc  (0x05<<0) /* 32 results accumulated */
#define ADC_SAMPNUM_ACC64_gc  (0x06<<0) /* 64 results accumulated */
#define ADC_SAMPNUM_ACC128_gc  (0x07<<0)  /* 128 results accumulated */
#define ADC_WINCM_NONE_gc  (0x00<<0) /* No Window Comparison */
#define ADC_WINCM_BELOW_gc  (0x01<<0) /* Below Window */
#define ADC_WINCM_ABOVE_gc  (0x02<<0) /* Above Window */
#define ADC_WINCM_INSIDE_gc  (0x03<<0) /* Inside Window */
#define ADC_WINCM_OUTSIDE_gc  (0x04<<0)  /* Outside Window */
#define BOD_ACTIVE_DIS_gc  (0x00<<2) /* Disabled */
#define BOD_ACTIVE_ENABLED_gc  (0x01<<2) /* Enabled */
#define BOD_ACTIVE_SAMPLED_gc  (0x02<<2) /* Sampled */
#define BOD_ACTIVE_ENWAKE_gc  (0x03<<2)  /* Enabled with wake-up halted until BOD is ready */
#define BOD_LVL_BODLEVEL0_gc  (0x00<<0) /* 1.9 V */
#define BOD_LVL_BODLEVEL1_gc  (0x01<<0) /* 2.45 V */
#define BOD_LVL_BODLEVEL2_gc  (0x02<<0) /* 2.7 V */
#define BOD_LVL_BODLEVEL3_gc  (0x03<<0)  /* 2.85 V */
#define BOD_SAMPFREQ_128HZ_gc  (0x00<<4) /* 128Hz sampling frequency */
#define BOD_SAMPFREQ_32HZ_gc  (0x01<<4)  /* 32Hz sampling frequency */
#define BOD_SLEEP_DIS_gc  (0x00<<0) /* Disabled */
#define BOD_SLEEP_ENABLED_gc  (0x01<<0) /* Enabled */
#define BOD_SLEEP_SAMPLED_gc  (0x02<<0)  /* Sampled */
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
#define CCL_CLKSRC_IN2_gc  (0x01<<1) /* Selection by INSEL2 */
#define CCL_CLKSRC_OSCHF_gc  (0x04<<1) /* Internal High-Frequency Oscillator */
#define CCL_CLKSRC_OSC32K_gc  (0x05<<1) /* 32.768 kHz oscillator */
#define CCL_CLKSRC_OSC1K_gc  (0x06<<1)  /* 32.768 kHz oscillator divided by 32 */
#define CCL_EDGEDET_DIS_gc  (0x00<<7) /* Edge detector is disabled */
#define CCL_EDGEDET_EN_gc  (0x01<<7)  /* Edge detector is enabled */
#define CCL_FILTSEL_DISABLE_gc  (0x00<<4) /* Filter disabled */
#define CCL_FILTSEL_SYNCH_gc  (0x01<<4) /* Synchronizer enabled */
#define CCL_FILTSEL_FILTER_gc  (0x02<<4)  /* Filter enabled */
#define CCL_INSEL0_MASK_gc  (0x00<<0) /* Masked input */
#define CCL_INSEL0_FEEDBACK_gc  (0x01<<0) /* Feedback input source */
#define CCL_INSEL0_LINK_gc  (0x02<<0) /* Linked LUT input source */
#define CCL_INSEL0_EVENTA_gc  (0x03<<0) /* Event input source A */
#define CCL_INSEL0_EVENTB_gc  (0x04<<0) /* Event input source B */
#define CCL_INSEL0_IN0_gc  (0x05<<0) /* IO pin LUTn-IN0 input source */
#define CCL_INSEL0_AC0_gc  (0x06<<0) /* AC0 OUT input source */
#define CCL_INSEL0_ZCD3_gc  (0x07<<0) /* ZCD3 OUT input source */
#define CCL_INSEL0_USART0_gc  (0x08<<0) /* USART0 TXD input source */
#define CCL_INSEL0_SPI0_gc  (0x09<<0) /* SPI0 MOSI input source */
#define CCL_INSEL0_TCA0_gc  (0x0A<<0) /* TCA0 WO0 input source */
#define CCL_INSEL0_TCB0_gc  (0x0B<<0) /* TCB0 WO input source */
#define CCL_INSEL0_TCD0_gc  (0x0C<<0)  /* TCD0 WOA input source */
#define CCL_INSEL1_MASK_gc  (0x00<<4) /* Masked input */
#define CCL_INSEL1_FEEDBACK_gc  (0x01<<4) /* Feedback input source */
#define CCL_INSEL1_LINK_gc  (0x02<<4) /* Linked LUT input source */
#define CCL_INSEL1_EVENTA_gc  (0x03<<4) /* Event input source A */
#define CCL_INSEL1_EVENTB_gc  (0x04<<4) /* Event input source B */
#define CCL_INSEL1_IN1_gc  (0x05<<4) /* IO pin LUTn-IN1 input source */
#define CCL_INSEL1_AC0_gc  (0x06<<4) /* AC0 OUT input source */
#define CCL_INSEL1_ZCD3_gc  (0x07<<4) /* ZCD3 OUT input source */
#define CCL_INSEL1_USART1_gc  (0x08<<4) /* USART1 TXD input source */
#define CCL_INSEL1_SPI0_gc  (0x09<<4) /* SPI0 MOSI input source */
#define CCL_INSEL1_TCA0_gc  (0x0A<<4) /* TCA0 WO1 input source */
#define CCL_INSEL1_TCB1_gc  (0x0B<<4) /* TCB1 WO input source */
#define CCL_INSEL1_TCD0_gc  (0x0C<<4)  /* TCD0 WOB input source */
#define CCL_INSEL2_MASK_gc  (0x00<<0) /* Masked input */
#define CCL_INSEL2_FEEDBACK_gc  (0x01<<0) /* Feedback input source */
#define CCL_INSEL2_LINK_gc  (0x02<<0) /* Linked LUT input source */
#define CCL_INSEL2_EVENTA_gc  (0x03<<0) /* Event input source A */
#define CCL_INSEL2_EVENTB_gc  (0x04<<0) /* Event input source B */
#define CCL_INSEL2_IN2_gc  (0x05<<0) /* IO pin LUTn-IN2 input source */
#define CCL_INSEL2_AC0_gc  (0x06<<0) /* AC0 OUT input source */
#define CCL_INSEL2_ZCD3_gc  (0x07<<0) /* ZCD3 OUT input source */
#define CCL_INSEL2_USART1_gc  (0x08<<0) /* USART1 TXD input source */
#define CCL_INSEL2_SPI0_gc  (0x09<<0) /* SPI0 SCK input source */
#define CCL_INSEL2_TCA0_gc  (0x0A<<0) /* TCA0 WO2 input source */
#define CCL_INSEL2_TCB2_gc  (0x0B<<0) /* TCB2 WO input source */
#define CCL_INSEL2_TCD0_gc  (0x0C<<0)  /* TCD0 WOC input source */
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
#define CLKCTRL_CFDSRC_CLKMAIN_gc  (0x00<<2) /* Main Clock */
#define CLKCTRL_CFDSRC_XOSCHF_gc  (0x01<<2) /* XOSCHF */
#define CLKCTRL_CFDSRC_XOSC32K_gc  (0x02<<2)  /* XOSC32K */
#define CLKCTRL_CLKSEL_OSCHF_gc  (0x00<<0) /* Internal high-frequency oscillator */
#define CLKCTRL_CLKSEL_OSC32K_gc  (0x01<<0) /* Internal 32.768 kHz oscillator */
#define CLKCTRL_CLKSEL_XOSC32K_gc  (0x02<<0) /* 32.768 kHz crystal oscillator */
#define CLKCTRL_CLKSEL_EXTCLK_gc  (0x03<<0)  /* External clock */
#define CLKCTRL_CSUT_1K_gc  (0x00<<4) /* 1k cycles */
#define CLKCTRL_CSUT_16K_gc  (0x01<<4) /* 16k cycles */
#define CLKCTRL_CSUT_32K_gc  (0x02<<4) /* 32k cycles */
#define CLKCTRL_CSUT_64K_gc  (0x03<<4)  /* 64k cycles */
#define CLKCTRL_CSUTHF_256_gc  (0x00<<4) /* 256 XOSCHF cycles */
#define CLKCTRL_CSUTHF_1K_gc  (0x01<<4) /* 1K XOSCHF cycles */
#define CLKCTRL_CSUTHF_4K_gc  (0x02<<4)  /* 4K XOSCHF cycles */
#define CLKCTRL_FRQRANGE_8M_gc  (0x00<<2) /* Max 8 MHz XTAL Frequency */
#define CLKCTRL_FRQRANGE_16M_gc  (0x01<<2) /* Max 16 MHz XTAL Frequency */
#define CLKCTRL_FRQRANGE_24M_gc  (0x02<<2) /* Max 24 MHz XTAL Frequency */
#define CLKCTRL_FRQRANGE_32M_gc  (0x03<<2)  /* Max 32 MHz XTAL Frequency */
#define CLKCTRL_FRQSEL_1M_gc  (0x00<<2) /* 1 MHz system clock */
#define CLKCTRL_FRQSEL_2M_gc  (0x01<<2) /* 2 MHz system clock */
#define CLKCTRL_FRQSEL_3M_gc  (0x02<<2) /* 3 MHz system clock */
#define CLKCTRL_FRQSEL_4M_gc  (0x03<<2) /* 4 MHz system clock (default) */
#define CLKCTRL_FRQSEL_8M_gc  (0x05<<2) /* 8 MHz system clock */
#define CLKCTRL_FRQSEL_12M_gc  (0x06<<2) /* 12 MHz system clock */
#define CLKCTRL_FRQSEL_16M_gc  (0x07<<2) /* 16 MHz system clock */
#define CLKCTRL_FRQSEL_20M_gc  (0x08<<2) /* 20 MHz system clock */
#define CLKCTRL_FRQSEL_24M_gc  (0x09<<2)  /* 24 MHz system clock */
#define CLKCTRL_INTTYPE_INT_gc  (0x00<<7) /* Regular Interrupt */
#define CLKCTRL_INTTYPE_NMI_gc  (0x01<<7)  /* NMI */
#define CLKCTRL_MULFAC_DISABLE_gc  (0x00<<0) /* PLL is disabled */
#define CLKCTRL_MULFAC_2x_gc  (0x01<<0) /* 2 x multiplication factor */
#define CLKCTRL_MULFAC_3x_gc  (0x02<<0)  /* 3 x multiplication factor */
#define CLKCTRL_PDIV_2X_gc  (0x00<<1) /* 2X */
#define CLKCTRL_PDIV_4X_gc  (0x01<<1) /* 4X */
#define CLKCTRL_PDIV_8X_gc  (0x02<<1) /* 8X */
#define CLKCTRL_PDIV_16X_gc  (0x03<<1) /* 16X */
#define CLKCTRL_PDIV_32X_gc  (0x04<<1) /* 32X */
#define CLKCTRL_PDIV_64X_gc  (0x05<<1) /* 64X */
#define CLKCTRL_PDIV_6X_gc  (0x08<<1) /* 6X */
#define CLKCTRL_PDIV_10X_gc  (0x09<<1) /* 10X */
#define CLKCTRL_PDIV_12X_gc  (0x0A<<1) /* 12X */
#define CLKCTRL_PDIV_24X_gc  (0x0B<<1) /* 24X */
#define CLKCTRL_PDIV_48X_gc  (0x0C<<1)  /* 48X */
#define CLKCTRL_SELHF_XTAL_gc  (0x00<<1) /* External Crystal */
#define CLKCTRL_SELHF_EXTCLOCK_gc  (0x01<<1)  /* External clock on XTALHF1 pin */
#define CLKCTRL_SOURCE_OSCHF_gc  (0x00<<6) /* High frequency internal oscillator as PLL source */
#define CLKCTRL_SOURCE_XOSCHF_gc  (0x01<<6)  /* High frequency external clock or external high frequency oscillator as PLL source */
#define CCP_SPM_gc  (0x9D<<0) /* SPM Instruction Protection */
#define CCP_IOREG_gc  (0xD8<<0)  /* IO Register Protection */
#define CRCSCAN_SRC_FLASH_gc  (0x00<<0) /* CRC on entire flash */
#define CRCSCAN_SRC_APPLICATION_gc  (0x01<<0) /* CRC on boot and appl section of flash */
#define CRCSCAN_SRC_BOOT_gc  (0x02<<0)  /* CRC on boot section of flash */
#define EVSYS_CHANNEL0_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_CHANNEL0_UPDI_SYNCH_gc  (0x01<<0) /* UPDI SYNCH character */
#define EVSYS_CHANNEL0_MVIO_gc  (0x05<<0) /* MVIO VDDIO2 OK */
#define EVSYS_CHANNEL0_RTC_OVF_gc  (0x06<<0) /* Real Time Counter overflow */
#define EVSYS_CHANNEL0_RTC_CMP_gc  (0x07<<0) /* Real Time Counter compare */
#define EVSYS_CHANNEL0_RTC_PIT_DIV8192_gc  (0x08<<0) /* Periodic Interrupt Timer output 0 */
#define EVSYS_CHANNEL0_RTC_PIT_DIV4096_gc  (0x09<<0) /* Periodic Interrupt Timer output 1 */
#define EVSYS_CHANNEL0_RTC_PIT_DIV2048_gc  (0x0A<<0) /* Periodic Interrupt Timer output 2 */
#define EVSYS_CHANNEL0_RTC_PIT_DIV1024_gc  (0x0B<<0) /* Periodic Interrupt Timer output 3 */
#define EVSYS_CHANNEL0_CCL_LUT0_gc  (0x10<<0) /* Configurable Custom Logic LUT0 */
#define EVSYS_CHANNEL0_CCL_LUT1_gc  (0x11<<0) /* Configurable Custom Logic LUT1 */
#define EVSYS_CHANNEL0_CCL_LUT2_gc  (0x12<<0) /* Configurable Custom Logic LUT2 */
#define EVSYS_CHANNEL0_CCL_LUT3_gc  (0x13<<0) /* Configurable Custom Logic LUT3 */
#define EVSYS_CHANNEL0_AC0_OUT_gc  (0x20<<0) /* Analog Comparator 0 out */
#define EVSYS_CHANNEL0_ADC0_RESRDY_gc  (0x24<<0) /* ADC 0 Result Ready */
#define EVSYS_CHANNEL0_ZCD3_gc  (0x30<<0) /* Zero Cross Detect 3 out */
#define EVSYS_CHANNEL0_PORTA_PIN0_gc  (0x40<<0) /* Port A Pin 0 */
#define EVSYS_CHANNEL0_PORTA_PIN1_gc  (0x41<<0) /* Port A Pin 1 */
#define EVSYS_CHANNEL0_PORTA_PIN2_gc  (0x42<<0) /* Port A Pin 2 */
#define EVSYS_CHANNEL0_PORTA_PIN3_gc  (0x43<<0) /* Port A Pin 3 */
#define EVSYS_CHANNEL0_PORTA_PIN4_gc  (0x44<<0) /* Port A Pin 4 */
#define EVSYS_CHANNEL0_PORTA_PIN5_gc  (0x45<<0) /* Port A Pin 5 */
#define EVSYS_CHANNEL0_PORTA_PIN6_gc  (0x46<<0) /* Port A Pin 6 */
#define EVSYS_CHANNEL0_PORTA_PIN7_gc  (0x47<<0) /* Port A Pin 7 */
#define EVSYS_CHANNEL0_USART0_XCK_gc  (0x60<<0) /* USART 0 XCK */
#define EVSYS_CHANNEL0_USART1_XCK_gc  (0x61<<0) /* USART 1 XCK */
#define EVSYS_CHANNEL0_SPI0_SCK_gc  (0x68<<0) /* SPI 0 SCK */
#define EVSYS_CHANNEL0_TCA0_OVF_LUNF_gc  (0x80<<0) /* Timer/Counter A0 overflow / low byte timer underflow */
#define EVSYS_CHANNEL0_TCA0_HUNF_gc  (0x81<<0) /* Timer/Counter A0 high byte timer underflow */
#define EVSYS_CHANNEL0_TCA0_CMP0_LCMP0_gc  (0x84<<0) /* Timer/Counter A0 compare 0 / low byte timer compare 0 */
#define EVSYS_CHANNEL0_TCA0_CMP1_LCMP1_gc  (0x85<<0) /* Timer/Counter A0 compare 1 / low byte timer compare 1 */
#define EVSYS_CHANNEL0_TCA0_CMP2_LCMP2_gc  (0x86<<0) /* Timer/Counter A0 compare 2 / low byte timer compare 2 */
#define EVSYS_CHANNEL0_TCB0_CAPT_gc  (0xA0<<0) /* Timer/Counter B0 capture */
#define EVSYS_CHANNEL0_TCB0_OVF_gc  (0xA1<<0) /* Timer/Counter B0 overflow */
#define EVSYS_CHANNEL0_TCB1_CAPT_gc  (0xA2<<0) /* Timer/Counter B1 capture */
#define EVSYS_CHANNEL0_TCB1_OVF_gc  (0xA3<<0) /* Timer/Counter B1 overflow */
#define EVSYS_CHANNEL0_TCB2_CAPT_gc  (0xA4<<0) /* Timer/Counter B2 capture */
#define EVSYS_CHANNEL0_TCB2_OVF_gc  (0xA5<<0) /* Timer/Counter B2 overflow */
#define EVSYS_CHANNEL0_TCD0_CMPBCLR_gc  (0xB0<<0) /* Timer/Counter D0 event 0 */
#define EVSYS_CHANNEL0_TCD0_CMPASET_gc  (0xB1<<0) /* Timer/Counter D0 event 1 */
#define EVSYS_CHANNEL0_TCD0_CMPBSET_gc  (0xB2<<0) /* Timer/Counter D0 event 2 */
#define EVSYS_CHANNEL0_TCD0_PROGEV_gc  (0xB3<<0)  /* Timer/Counter D0 event 3 */
#define EVSYS_CHANNEL1_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_CHANNEL1_UPDI_SYNCH_gc  (0x01<<0) /* UPDI SYNCH character */
#define EVSYS_CHANNEL1_MVIO_gc  (0x05<<0) /* MVIO VDDIO2 OK */
#define EVSYS_CHANNEL1_RTC_OVF_gc  (0x06<<0) /* Real Time Counter overflow */
#define EVSYS_CHANNEL1_RTC_CMP_gc  (0x07<<0) /* Real Time Counter compare */
#define EVSYS_CHANNEL1_RTC_PIT_DIV512_gc  (0x08<<0) /* Periodic Interrupt Timer output 0 */
#define EVSYS_CHANNEL1_RTC_PIT_DIV256_gc  (0x09<<0) /* Periodic Interrupt Timer output 1 */
#define EVSYS_CHANNEL1_RTC_PIT_DIV128_gc  (0x0A<<0) /* Periodic Interrupt Timer output 2 */
#define EVSYS_CHANNEL1_RTC_PIT_DIV64_gc  (0x0B<<0) /* Periodic Interrupt Timer output 3 */
#define EVSYS_CHANNEL1_CCL_LUT0_gc  (0x10<<0) /* Configurable Custom Logic LUT0 */
#define EVSYS_CHANNEL1_CCL_LUT1_gc  (0x11<<0) /* Configurable Custom Logic LUT1 */
#define EVSYS_CHANNEL1_CCL_LUT2_gc  (0x12<<0) /* Configurable Custom Logic LUT2 */
#define EVSYS_CHANNEL1_CCL_LUT3_gc  (0x13<<0) /* Configurable Custom Logic LUT3 */
#define EVSYS_CHANNEL1_AC0_OUT_gc  (0x20<<0) /* Analog Comparator 0 out */
#define EVSYS_CHANNEL1_ADC0_RESRDY_gc  (0x24<<0) /* ADC 0 Result Ready */
#define EVSYS_CHANNEL1_ZCD3_gc  (0x30<<0) /* Zero Cross Detect 3 out */
#define EVSYS_CHANNEL1_PORTA_PIN0_gc  (0x40<<0) /* Port A Pin 0 */
#define EVSYS_CHANNEL1_PORTA_PIN1_gc  (0x41<<0) /* Port A Pin 1 */
#define EVSYS_CHANNEL1_PORTA_PIN2_gc  (0x42<<0) /* Port A Pin 2 */
#define EVSYS_CHANNEL1_PORTA_PIN3_gc  (0x43<<0) /* Port A Pin 3 */
#define EVSYS_CHANNEL1_PORTA_PIN4_gc  (0x44<<0) /* Port A Pin 4 */
#define EVSYS_CHANNEL1_PORTA_PIN5_gc  (0x45<<0) /* Port A Pin 5 */
#define EVSYS_CHANNEL1_PORTA_PIN6_gc  (0x46<<0) /* Port A Pin 6 */
#define EVSYS_CHANNEL1_PORTA_PIN7_gc  (0x47<<0) /* Port A Pin 7 */
#define EVSYS_CHANNEL1_USART0_XCK_gc  (0x60<<0) /* USART 0 XCK */
#define EVSYS_CHANNEL1_USART1_XCK_gc  (0x61<<0) /* USART 1 XCK */
#define EVSYS_CHANNEL1_SPI0_SCK_gc  (0x68<<0) /* SPI 0 SCK */
#define EVSYS_CHANNEL1_TCA0_OVF_LUNF_gc  (0x80<<0) /* Timer/Counter A0 overflow / low byte timer underflow */
#define EVSYS_CHANNEL1_TCA0_HUNF_gc  (0x81<<0) /* Timer/Counter A0 high byte timer underflow */
#define EVSYS_CHANNEL1_TCA0_CMP0_LCMP0_gc  (0x84<<0) /* Timer/Counter A0 compare 0 / low byte timer compare 0 */
#define EVSYS_CHANNEL1_TCA0_CMP1_LCMP1_gc  (0x85<<0) /* Timer/Counter A0 compare 1 / low byte timer compare 1 */
#define EVSYS_CHANNEL1_TCA0_CMP2_LCMP2_gc  (0x86<<0) /* Timer/Counter A0 compare 2 / low byte timer compare 2 */
#define EVSYS_CHANNEL1_TCB0_CAPT_gc  (0xA0<<0) /* Timer/Counter B0 capture */
#define EVSYS_CHANNEL1_TCB0_OVF_gc  (0xA1<<0) /* Timer/Counter B0 overflow */
#define EVSYS_CHANNEL1_TCB1_CAPT_gc  (0xA2<<0) /* Timer/Counter B1 capture */
#define EVSYS_CHANNEL1_TCB1_OVF_gc  (0xA3<<0) /* Timer/Counter B1 overflow */
#define EVSYS_CHANNEL1_TCB2_CAPT_gc  (0xA4<<0) /* Timer/Counter B2 capture */
#define EVSYS_CHANNEL1_TCB2_OVF_gc  (0xA5<<0) /* Timer/Counter B2 overflow */
#define EVSYS_CHANNEL1_TCD0_CMPBCLR_gc  (0xB0<<0) /* Timer/Counter D0 event 0 */
#define EVSYS_CHANNEL1_TCD0_CMPASET_gc  (0xB1<<0) /* Timer/Counter D0 event 1 */
#define EVSYS_CHANNEL1_TCD0_CMPBSET_gc  (0xB2<<0) /* Timer/Counter D0 event 2 */
#define EVSYS_CHANNEL1_TCD0_PROGEV_gc  (0xB3<<0)  /* Timer/Counter D0 event 3 */
#define EVSYS_CHANNEL2_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_CHANNEL2_UPDI_SYNCH_gc  (0x01<<0) /* UPDI SYNCH character */
#define EVSYS_CHANNEL2_MVIO_gc  (0x05<<0) /* MVIO VDDIO2 OK */
#define EVSYS_CHANNEL2_RTC_OVF_gc  (0x06<<0) /* Real Time Counter overflow */
#define EVSYS_CHANNEL2_RTC_CMP_gc  (0x07<<0) /* Real Time Counter compare */
#define EVSYS_CHANNEL2_RTC_PIT_DIV8192_gc  (0x08<<0) /* Periodic Interrupt Timer output 0 */
#define EVSYS_CHANNEL2_RTC_PIT_DIV4096_gc  (0x09<<0) /* Periodic Interrupt Timer output 1 */
#define EVSYS_CHANNEL2_RTC_PIT_DIV2048_gc  (0x0A<<0) /* Periodic Interrupt Timer output 2 */
#define EVSYS_CHANNEL2_RTC_PIT_DIV1024_gc  (0x0B<<0) /* Periodic Interrupt Timer output 3 */
#define EVSYS_CHANNEL2_CCL_LUT0_gc  (0x10<<0) /* Configurable Custom Logic LUT0 */
#define EVSYS_CHANNEL2_CCL_LUT1_gc  (0x11<<0) /* Configurable Custom Logic LUT1 */
#define EVSYS_CHANNEL2_CCL_LUT2_gc  (0x12<<0) /* Configurable Custom Logic LUT2 */
#define EVSYS_CHANNEL2_CCL_LUT3_gc  (0x13<<0) /* Configurable Custom Logic LUT3 */
#define EVSYS_CHANNEL2_AC0_OUT_gc  (0x20<<0) /* Analog Comparator 0 out */
#define EVSYS_CHANNEL2_ADC0_RESRDY_gc  (0x24<<0) /* ADC 0 Result Ready */
#define EVSYS_CHANNEL2_ZCD3_gc  (0x30<<0) /* Zero Cross Detect 3 out */
#define EVSYS_CHANNEL2_PORTC_PIN0_gc  (0x40<<0) /* Port C Pin 0 */
#define EVSYS_CHANNEL2_PORTC_PIN1_gc  (0x41<<0) /* Port C Pin 1 */
#define EVSYS_CHANNEL2_PORTC_PIN2_gc  (0x42<<0) /* Port C Pin 2 */
#define EVSYS_CHANNEL2_PORTC_PIN3_gc  (0x43<<0) /* Port C Pin 3 */
#define EVSYS_CHANNEL2_PORTD_PIN1_gc  (0x49<<0) /* Port D Pin 1 */
#define EVSYS_CHANNEL2_PORTD_PIN2_gc  (0x4A<<0) /* Port D Pin 2 */
#define EVSYS_CHANNEL2_PORTD_PIN3_gc  (0x4B<<0) /* Port D Pin 3 */
#define EVSYS_CHANNEL2_PORTD_PIN4_gc  (0x4C<<0) /* Port D Pin 4 */
#define EVSYS_CHANNEL2_PORTD_PIN5_gc  (0x4D<<0) /* Port D Pin 5 */
#define EVSYS_CHANNEL2_PORTD_PIN6_gc  (0x4E<<0) /* Port D Pin 6 */
#define EVSYS_CHANNEL2_PORTD_PIN7_gc  (0x4F<<0) /* Port D Pin 7 */
#define EVSYS_CHANNEL2_USART0_XCK_gc  (0x60<<0) /* USART 0 XCK */
#define EVSYS_CHANNEL2_USART1_XCK_gc  (0x61<<0) /* USART 1 XCK */
#define EVSYS_CHANNEL2_SPI0_SCK_gc  (0x68<<0) /* SPI 0 SCK */
#define EVSYS_CHANNEL2_TCA0_OVF_LUNF_gc  (0x80<<0) /* Timer/Counter A0 overflow / low byte timer underflow */
#define EVSYS_CHANNEL2_TCA0_HUNF_gc  (0x81<<0) /* Timer/Counter A0 high byte timer underflow */
#define EVSYS_CHANNEL2_TCA0_CMP0_LCMP0_gc  (0x84<<0) /* Timer/Counter A0 compare 0 / low byte timer compare 0 */
#define EVSYS_CHANNEL2_TCA0_CMP1_LCMP1_gc  (0x85<<0) /* Timer/Counter A0 compare 1 / low byte timer compare 1 */
#define EVSYS_CHANNEL2_TCA0_CMP2_LCMP2_gc  (0x86<<0) /* Timer/Counter A0 compare 2 / low byte timer compare 2 */
#define EVSYS_CHANNEL2_TCB0_CAPT_gc  (0xA0<<0) /* Timer/Counter B0 capture */
#define EVSYS_CHANNEL2_TCB0_OVF_gc  (0xA1<<0) /* Timer/Counter B0 overflow */
#define EVSYS_CHANNEL2_TCB1_CAPT_gc  (0xA2<<0) /* Timer/Counter B1 capture */
#define EVSYS_CHANNEL2_TCB1_OVF_gc  (0xA3<<0) /* Timer/Counter B1 overflow */
#define EVSYS_CHANNEL2_TCB2_CAPT_gc  (0xA4<<0) /* Timer/Counter B2 capture */
#define EVSYS_CHANNEL2_TCB2_OVF_gc  (0xA5<<0) /* Timer/Counter B2 overflow */
#define EVSYS_CHANNEL2_TCD0_CMPBCLR_gc  (0xB0<<0) /* Timer/Counter D0 event 0 */
#define EVSYS_CHANNEL2_TCD0_CMPASET_gc  (0xB1<<0) /* Timer/Counter D0 event 1 */
#define EVSYS_CHANNEL2_TCD0_CMPBSET_gc  (0xB2<<0) /* Timer/Counter D0 event 2 */
#define EVSYS_CHANNEL2_TCD0_PROGEV_gc  (0xB3<<0)  /* Timer/Counter D0 event 3 */
#define EVSYS_CHANNEL3_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_CHANNEL3_UPDI_SYNCH_gc  (0x01<<0) /* UPDI SYNCH character */
#define EVSYS_CHANNEL3_MVIO_gc  (0x05<<0) /* MVIO VDDIO2 OK */
#define EVSYS_CHANNEL3_RTC_OVF_gc  (0x06<<0) /* Real Time Counter overflow */
#define EVSYS_CHANNEL3_RTC_CMP_gc  (0x07<<0) /* Real Time Counter compare */
#define EVSYS_CHANNEL3_RTC_PIT_DIV512_gc  (0x08<<0) /* Periodic Interrupt Timer output 0 */
#define EVSYS_CHANNEL3_RTC_PIT_DIV256_gc  (0x09<<0) /* Periodic Interrupt Timer output 1 */
#define EVSYS_CHANNEL3_RTC_PIT_DIV128_gc  (0x0A<<0) /* Periodic Interrupt Timer output 2 */
#define EVSYS_CHANNEL3_RTC_PIT_DIV64_gc  (0x0B<<0) /* Periodic Interrupt Timer output 3 */
#define EVSYS_CHANNEL3_CCL_LUT0_gc  (0x10<<0) /* Configurable Custom Logic LUT0 */
#define EVSYS_CHANNEL3_CCL_LUT1_gc  (0x11<<0) /* Configurable Custom Logic LUT1 */
#define EVSYS_CHANNEL3_CCL_LUT2_gc  (0x12<<0) /* Configurable Custom Logic LUT2 */
#define EVSYS_CHANNEL3_CCL_LUT3_gc  (0x13<<0) /* Configurable Custom Logic LUT3 */
#define EVSYS_CHANNEL3_AC0_OUT_gc  (0x20<<0) /* Analog Comparator 0 out */
#define EVSYS_CHANNEL3_ADC0_RESRDY_gc  (0x24<<0) /* ADC 0 Result Ready */
#define EVSYS_CHANNEL3_ZCD3_gc  (0x30<<0) /* Zero Cross Detect 3 out */
#define EVSYS_CHANNEL3_PORTC_PIN0_gc  (0x40<<0) /* Port C Pin 0 */
#define EVSYS_CHANNEL3_PORTC_PIN1_gc  (0x41<<0) /* Port C Pin 1 */
#define EVSYS_CHANNEL3_PORTC_PIN2_gc  (0x42<<0) /* Port C Pin 2 */
#define EVSYS_CHANNEL3_PORTC_PIN3_gc  (0x43<<0) /* Port C Pin 3 */
#define EVSYS_CHANNEL3_PORTD_PIN1_gc  (0x49<<0) /* Port D Pin 1 */
#define EVSYS_CHANNEL3_PORTD_PIN2_gc  (0x4A<<0) /* Port D Pin 2 */
#define EVSYS_CHANNEL3_PORTD_PIN3_gc  (0x4B<<0) /* Port D Pin 3 */
#define EVSYS_CHANNEL3_PORTD_PIN4_gc  (0x4C<<0) /* Port D Pin 4 */
#define EVSYS_CHANNEL3_PORTD_PIN5_gc  (0x4D<<0) /* Port D Pin 5 */
#define EVSYS_CHANNEL3_PORTD_PIN6_gc  (0x4E<<0) /* Port D Pin 6 */
#define EVSYS_CHANNEL3_PORTD_PIN7_gc  (0x4F<<0) /* Port D Pin 7 */
#define EVSYS_CHANNEL3_USART0_XCK_gc  (0x60<<0) /* USART 0 XCK */
#define EVSYS_CHANNEL3_USART1_XCK_gc  (0x61<<0) /* USART 1 XCK */
#define EVSYS_CHANNEL3_SPI0_SCK_gc  (0x68<<0) /* SPI 0 SCK */
#define EVSYS_CHANNEL3_TCA0_OVF_LUNF_gc  (0x80<<0) /* Timer/Counter A0 overflow / low byte timer underflow */
#define EVSYS_CHANNEL3_TCA0_HUNF_gc  (0x81<<0) /* Timer/Counter A0 high byte timer underflow */
#define EVSYS_CHANNEL3_TCA0_CMP0_LCMP0_gc  (0x84<<0) /* Timer/Counter A0 compare 0 / low byte timer compare 0 */
#define EVSYS_CHANNEL3_TCA0_CMP1_LCMP1_gc  (0x85<<0) /* Timer/Counter A0 compare 1 / low byte timer compare 1 */
#define EVSYS_CHANNEL3_TCA0_CMP2_LCMP2_gc  (0x86<<0) /* Timer/Counter A0 compare 2 / low byte timer compare 2 */
#define EVSYS_CHANNEL3_TCB0_CAPT_gc  (0xA0<<0) /* Timer/Counter B0 capture */
#define EVSYS_CHANNEL3_TCB0_OVF_gc  (0xA1<<0) /* Timer/Counter B0 overflow */
#define EVSYS_CHANNEL3_TCB1_CAPT_gc  (0xA2<<0) /* Timer/Counter B1 capture */
#define EVSYS_CHANNEL3_TCB1_OVF_gc  (0xA3<<0) /* Timer/Counter B1 overflow */
#define EVSYS_CHANNEL3_TCB2_CAPT_gc  (0xA4<<0) /* Timer/Counter B2 capture */
#define EVSYS_CHANNEL3_TCB2_OVF_gc  (0xA5<<0) /* Timer/Counter B2 overflow */
#define EVSYS_CHANNEL3_TCD0_CMPBCLR_gc  (0xB0<<0) /* Timer/Counter D0 event 0 */
#define EVSYS_CHANNEL3_TCD0_CMPASET_gc  (0xB1<<0) /* Timer/Counter D0 event 1 */
#define EVSYS_CHANNEL3_TCD0_CMPBSET_gc  (0xB2<<0) /* Timer/Counter D0 event 2 */
#define EVSYS_CHANNEL3_TCD0_PROGEV_gc  (0xB3<<0)  /* Timer/Counter D0 event 3 */
#define EVSYS_CHANNEL4_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_CHANNEL4_UPDI_SYNCH_gc  (0x01<<0) /* UPDI SYNCH character */
#define EVSYS_CHANNEL4_MVIO_gc  (0x05<<0) /* MVIO VDDIO2 OK */
#define EVSYS_CHANNEL4_RTC_OVF_gc  (0x06<<0) /* Real Time Counter overflow */
#define EVSYS_CHANNEL4_RTC_CMP_gc  (0x07<<0) /* Real Time Counter compare */
#define EVSYS_CHANNEL4_RTC_PIT_DIV8192_gc  (0x08<<0) /* Periodic Interrupt Timer output 0 */
#define EVSYS_CHANNEL4_RTC_PIT_DIV4096_gc  (0x09<<0) /* Periodic Interrupt Timer output 1 */
#define EVSYS_CHANNEL4_RTC_PIT_DIV2048_gc  (0x0A<<0) /* Periodic Interrupt Timer output 2 */
#define EVSYS_CHANNEL4_RTC_PIT_DIV1024_gc  (0x0B<<0) /* Periodic Interrupt Timer output 3 */
#define EVSYS_CHANNEL4_CCL_LUT0_gc  (0x10<<0) /* Configurable Custom Logic LUT0 */
#define EVSYS_CHANNEL4_CCL_LUT1_gc  (0x11<<0) /* Configurable Custom Logic LUT1 */
#define EVSYS_CHANNEL4_CCL_LUT2_gc  (0x12<<0) /* Configurable Custom Logic LUT2 */
#define EVSYS_CHANNEL4_CCL_LUT3_gc  (0x13<<0) /* Configurable Custom Logic LUT3 */
#define EVSYS_CHANNEL4_AC0_OUT_gc  (0x20<<0) /* Analog Comparator 0 out */
#define EVSYS_CHANNEL4_ADC0_RESRDY_gc  (0x24<<0) /* ADC 0 Result Ready */
#define EVSYS_CHANNEL4_ZCD3_gc  (0x30<<0) /* Zero Cross Detect 3 out */
#define EVSYS_CHANNEL4_PORTF_PIN0_gc  (0x48<<0) /* Port F Pin 0 */
#define EVSYS_CHANNEL4_PORTF_PIN1_gc  (0x49<<0) /* Port F Pin 1 */
#define EVSYS_CHANNEL4_PORTF_PIN6_gc  (0x4E<<0) /* Port F Pin 6 */
#define EVSYS_CHANNEL4_PORTF_PIN7_gc  (0x4F<<0) /* Port F Pin 7 */
#define EVSYS_CHANNEL4_USART0_XCK_gc  (0x60<<0) /* USART 0 XCK */
#define EVSYS_CHANNEL4_USART1_XCK_gc  (0x61<<0) /* USART 1 XCK */
#define EVSYS_CHANNEL4_SPI0_SCK_gc  (0x68<<0) /* SPI 0 SCK */
#define EVSYS_CHANNEL4_TCA0_OVF_LUNF_gc  (0x80<<0) /* Timer/Counter A0 overflow / low byte timer underflow */
#define EVSYS_CHANNEL4_TCA0_HUNF_gc  (0x81<<0) /* Timer/Counter A0 high byte timer underflow */
#define EVSYS_CHANNEL4_TCA0_CMP0_LCMP0_gc  (0x84<<0) /* Timer/Counter A0 compare 0 / low byte timer compare 0 */
#define EVSYS_CHANNEL4_TCA0_CMP1_LCMP1_gc  (0x85<<0) /* Timer/Counter A0 compare 1 / low byte timer compare 1 */
#define EVSYS_CHANNEL4_TCA0_CMP2_LCMP2_gc  (0x86<<0) /* Timer/Counter A0 compare 2 / low byte timer compare 2 */
#define EVSYS_CHANNEL4_TCB0_CAPT_gc  (0xA0<<0) /* Timer/Counter B0 capture */
#define EVSYS_CHANNEL4_TCB0_OVF_gc  (0xA1<<0) /* Timer/Counter B0 overflow */
#define EVSYS_CHANNEL4_TCB1_CAPT_gc  (0xA2<<0) /* Timer/Counter B1 capture */
#define EVSYS_CHANNEL4_TCB1_OVF_gc  (0xA3<<0) /* Timer/Counter B1 overflow */
#define EVSYS_CHANNEL4_TCB2_CAPT_gc  (0xA4<<0) /* Timer/Counter B2 capture */
#define EVSYS_CHANNEL4_TCB2_OVF_gc  (0xA5<<0) /* Timer/Counter B2 overflow */
#define EVSYS_CHANNEL4_TCD0_CMPBCLR_gc  (0xB0<<0) /* Timer/Counter D0 event 0 */
#define EVSYS_CHANNEL4_TCD0_CMPASET_gc  (0xB1<<0) /* Timer/Counter D0 event 1 */
#define EVSYS_CHANNEL4_TCD0_CMPBSET_gc  (0xB2<<0) /* Timer/Counter D0 event 2 */
#define EVSYS_CHANNEL4_TCD0_PROGEV_gc  (0xB3<<0)  /* Timer/Counter D0 event 3 */
#define EVSYS_CHANNEL5_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_CHANNEL5_UPDI_SYNCH_gc  (0x01<<0) /* UPDI SYNCH character */
#define EVSYS_CHANNEL5_MVIO_gc  (0x05<<0) /* MVIO VDDIO2 OK */
#define EVSYS_CHANNEL5_RTC_OVF_gc  (0x06<<0) /* Real Time Counter overflow */
#define EVSYS_CHANNEL5_RTC_CMP_gc  (0x07<<0) /* Real Time Counter compare */
#define EVSYS_CHANNEL5_RTC_PIT_DIV512_gc  (0x08<<0) /* Periodic Interrupt Timer output 0 */
#define EVSYS_CHANNEL5_RTC_PIT_DIV256_gc  (0x09<<0) /* Periodic Interrupt Timer output 1 */
#define EVSYS_CHANNEL5_RTC_PIT_DIV128_gc  (0x0A<<0) /* Periodic Interrupt Timer output 2 */
#define EVSYS_CHANNEL5_RTC_PIT_DIV64_gc  (0x0B<<0) /* Periodic Interrupt Timer output 3 */
#define EVSYS_CHANNEL5_CCL_LUT0_gc  (0x10<<0) /* Configurable Custom Logic LUT0 */
#define EVSYS_CHANNEL5_CCL_LUT1_gc  (0x11<<0) /* Configurable Custom Logic LUT1 */
#define EVSYS_CHANNEL5_CCL_LUT2_gc  (0x12<<0) /* Configurable Custom Logic LUT2 */
#define EVSYS_CHANNEL5_CCL_LUT3_gc  (0x13<<0) /* Configurable Custom Logic LUT3 */
#define EVSYS_CHANNEL5_AC0_OUT_gc  (0x20<<0) /* Analog Comparator 0 out */
#define EVSYS_CHANNEL5_ADC0_RESRDY_gc  (0x24<<0) /* ADC 0 Result Ready */
#define EVSYS_CHANNEL5_ZCD3_gc  (0x30<<0) /* Zero Cross Detect 3 out */
#define EVSYS_CHANNEL5_PORTF_PIN0_gc  (0x48<<0) /* Port F Pin 0 */
#define EVSYS_CHANNEL5_PORTF_PIN1_gc  (0x49<<0) /* Port F Pin 1 */
#define EVSYS_CHANNEL5_PORTF_PIN6_gc  (0x4E<<0) /* Port F Pin 6 */
#define EVSYS_CHANNEL5_PORTF_PIN7_gc  (0x4F<<0) /* Port F Pin 7 */
#define EVSYS_CHANNEL5_USART0_XCK_gc  (0x60<<0) /* USART 0 XCK */
#define EVSYS_CHANNEL5_USART1_XCK_gc  (0x61<<0) /* USART 1 XCK */
#define EVSYS_CHANNEL5_SPI0_SCK_gc  (0x68<<0) /* SPI 0 SCK */
#define EVSYS_CHANNEL5_TCA0_OVF_LUNF_gc  (0x80<<0) /* Timer/Counter A0 overflow / low byte timer underflow */
#define EVSYS_CHANNEL5_TCA0_HUNF_gc  (0x81<<0) /* Timer/Counter A0 high byte timer underflow */
#define EVSYS_CHANNEL5_TCA0_CMP0_LCMP0_gc  (0x84<<0) /* Timer/Counter A0 compare 0 / low byte timer compare 0 */
#define EVSYS_CHANNEL5_TCA0_CMP1_LCMP1_gc  (0x85<<0) /* Timer/Counter A0 compare 1 / low byte timer compare 1 */
#define EVSYS_CHANNEL5_TCA0_CMP2_LCMP2_gc  (0x86<<0) /* Timer/Counter A0 compare 2 / low byte timer compare 2 */
#define EVSYS_CHANNEL5_TCB0_CAPT_gc  (0xA0<<0) /* Timer/Counter B0 capture */
#define EVSYS_CHANNEL5_TCB0_OVF_gc  (0xA1<<0) /* Timer/Counter B0 overflow */
#define EVSYS_CHANNEL5_TCB1_CAPT_gc  (0xA2<<0) /* Timer/Counter B1 capture */
#define EVSYS_CHANNEL5_TCB1_OVF_gc  (0xA3<<0) /* Timer/Counter B1 overflow */
#define EVSYS_CHANNEL5_TCB2_CAPT_gc  (0xA4<<0) /* Timer/Counter B2 capture */
#define EVSYS_CHANNEL5_TCB2_OVF_gc  (0xA5<<0) /* Timer/Counter B2 overflow */
#define EVSYS_CHANNEL5_TCD0_CMPBCLR_gc  (0xB0<<0) /* Timer/Counter D0 event 0 */
#define EVSYS_CHANNEL5_TCD0_CMPASET_gc  (0xB1<<0) /* Timer/Counter D0 event 1 */
#define EVSYS_CHANNEL5_TCD0_CMPBSET_gc  (0xB2<<0) /* Timer/Counter D0 event 2 */
#define EVSYS_CHANNEL5_TCD0_PROGEV_gc  (0xB3<<0)  /* Timer/Counter D0 event 3 */
#define EVSYS_SWEVENTA_CH0_gc  (0x01<<0) /* Software event on channel 0 */
#define EVSYS_SWEVENTA_CH1_gc  (0x02<<0) /* Software event on channel 1 */
#define EVSYS_SWEVENTA_CH2_gc  (0x04<<0) /* Software event on channel 2 */
#define EVSYS_SWEVENTA_CH3_gc  (0x08<<0) /* Software event on channel 3 */
#define EVSYS_SWEVENTA_CH4_gc  (0x10<<0) /* Software event on channel 4 */
#define EVSYS_SWEVENTA_CH5_gc  (0x20<<0) /* Software event on channel 5 */
#define EVSYS_SWEVENTA_CH6_gc  (0x40<<0) /* Software event on channel 6 */
#define EVSYS_SWEVENTA_CH7_gc  (0x80<<0)  /* Software event on channel 7 */
#define EVSYS_SWEVENTB_CH8_gc  (0x00<<0) /* Software event on channel 8 */
#define EVSYS_SWEVENTB_CH9_gc  (0x01<<0)  /* Software event on channel 9 */
#define EVSYS_USER_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_USER_CHANNEL0_gc  (0x01<<0) /* Connect user to event channel 0 */
#define EVSYS_USER_CHANNEL1_gc  (0x02<<0) /* Connect user to event channel 1 */
#define EVSYS_USER_CHANNEL2_gc  (0x03<<0) /* Connect user to event channel 2 */
#define EVSYS_USER_CHANNEL3_gc  (0x04<<0) /* Connect user to event channel 3 */
#define EVSYS_USER_CHANNEL4_gc  (0x05<<0) /* Connect user to event channel 4 */
#define EVSYS_USER_CHANNEL5_gc  (0x06<<0)  /* Connect user to event channel 5 */
#define ACTIVE_DISABLE_gc  (0x00<<2) /* BOD disabled */
#define ACTIVE_ENABLE_gc  (0x01<<2) /* BOD enabled in continuous mode */
#define ACTIVE_SAMPLE_gc  (0x02<<2) /* BOD enabled in sampled mode */
#define ACTIVE_ENABLEWAIT_gc  (0x03<<2)  /* BOD enabled in continuous mode. Execution is halted at wake-up until BOD is running. */
#define CLKSEL_OSCHF_gc  (0x00<<0) /* 1-32MHz internal oscillator */
#define CLKSEL_OSC32K_gc  (0x01<<0)  /* 32.768kHz internal oscillator */
#define CRCSEL_CRC16_gc  (0x00<<5) /* Enable CRC16 */
#define CRCSEL_CRC32_gc  (0x01<<5)  /* Enable CRC32 */
#define CRCSRC_FLASH_gc  (0x00<<6) /* CRC of full Flash (boot, application code and application data) */
#define CRCSRC_BOOT_gc  (0x01<<6) /* CRC of boot section */
#define CRCSRC_BOOTAPP_gc  (0x02<<6) /* CRC of application code and boot sections */
#define CRCSRC_NOCRC_gc  (0x03<<6)  /* No CRC */
#define LVL_BODLEVEL0_gc  (0x00<<5) /* 1.9V */
#define LVL_BODLEVEL1_gc  (0x01<<5) /* 2.45V */
#define LVL_BODLEVEL2_gc  (0x02<<5) /* 2.7V */
#define LVL_BODLEVEL3_gc  (0x03<<5)  /* 2.85V */
#define MVSYSCFG_DUAL_gc  (0x01<<3) /* Device used in a dual supply configuration */
#define MVSYSCFG_SINGLE_gc  (0x02<<3)  /* Device used in a single supply configuration */
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
#define RSTPINCFG_GPIO_gc  (0x00<<3) /* GPIO mode */
#define RSTPINCFG_RST_gc  (0x01<<3)  /* Reset mode */
#define SAMPFREQ_128Hz_gc  (0x00<<4) /* Sample frequency is 128 Hz */
#define SAMPFREQ_32Hz_gc  (0x01<<4)  /* Sample frequency is 32 Hz */
#define SLEEP_DISABLE_gc  (0x00<<0) /* BOD disabled */
#define SLEEP_ENABLE_gc  (0x01<<0) /* BOD enabled in continuous mode */
#define SLEEP_SAMPLE_gc  (0x02<<0)  /* BOD enabled in sampled mode */
#define SUT_0MS_gc  (0x00<<0) /* 0 ms */
#define SUT_1MS_gc  (0x01<<0) /* 1 ms */
#define SUT_2MS_gc  (0x02<<0) /* 2 ms */
#define SUT_4MS_gc  (0x03<<0) /* 4 ms */
#define SUT_8MS_gc  (0x04<<0) /* 8 ms */
#define SUT_16MS_gc  (0x05<<0) /* 16 ms */
#define SUT_32MS_gc  (0x06<<0) /* 32 ms */
#define SUT_64MS_gc  (0x07<<0)  /* 64 ms */
#define UPDIPINCFG_GPIO_gc  (0x00<<4) /* GPIO Mode */
#define UPDIPINCFG_UPDI_gc  (0x01<<4)  /* UPDI Mode */
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
#define NVMCTRL_CMD_NONE_gc  (0x00<<0) /* No Command */
#define NVMCTRL_CMD_NOOP_gc  (0x01<<0) /* No Operation */
#define NVMCTRL_CMD_FLWR_gc  (0x02<<0) /* Flash Write */
#define NVMCTRL_CMD_FLPER_gc  (0x08<<0) /* Flash Page Erase */
#define NVMCTRL_CMD_FLMPER2_gc  (0x09<<0) /* Flash Multi-Page Erase 2 pages */
#define NVMCTRL_CMD_FLMPER4_gc  (0x0A<<0) /* Flash Multi-Page Erase 4 pages */
#define NVMCTRL_CMD_FLMPER8_gc  (0x0B<<0) /* Flash Multi-Page Erase 8 pages */
#define NVMCTRL_CMD_FLMPER16_gc  (0x0C<<0) /* Flash Multi-Page Erase 16 pages */
#define NVMCTRL_CMD_FLMPER32_gc  (0x0D<<0) /* Flash Multi-Page Erase 32 pages */
#define NVMCTRL_CMD_EEWR_gc  (0x12<<0) /* EEPROM Write */
#define NVMCTRL_CMD_EEERWR_gc  (0x13<<0) /* EEPROM Erase and Write */
#define NVMCTRL_CMD_EEBER_gc  (0x18<<0) /* EEPROM Byte Erase */
#define NVMCTRL_CMD_EEMBER2_gc  (0x19<<0) /* EEPROM Multi-Byte Erase 2 bytes */
#define NVMCTRL_CMD_EEMBER4_gc  (0x1A<<0) /* EEPROM Multi-Byte Erase 4 bytes */
#define NVMCTRL_CMD_EEMBER8_gc  (0x1B<<0) /* EEPROM Multi-Byte Erase 8 bytes */
#define NVMCTRL_CMD_EEMBER16_gc  (0x1C<<0) /* EEPROM Multi-Byte Erase 16 bytes */
#define NVMCTRL_CMD_EEMBER32_gc  (0x1D<<0) /* EEPROM Multi-Byte Erase 32 bytes */
#define NVMCTRL_CMD_CHER_gc  (0x20<<0) /* Chip Erase Command */
#define NVMCTRL_CMD_EECHER_gc  (0x30<<0)  /* EEPROM Erase Command */
#define NVMCTRL_ERROR_NOERROR_gc  (0x00<<4) /* No Error */
#define NVMCTRL_ERROR_ILLEGALCMD_gc  (0x01<<4) /* Write command not selected */
#define NVMCTRL_ERROR_ILLEGALSADDR_gc  (0x02<<4) /* Write to section not allowed */
#define NVMCTRL_ERROR_DOUBLESELECT_gc  (0x03<<4) /* Selecting new write command while write command already seleted */
#define NVMCTRL_ERROR_ONGOINGPROG_gc  (0x04<<4)  /* Starting a new programming operation before previous is completed */
#define NVMCTRL_FLMAP_SECTION0_gc  (0x00<<4) /* Flash section 0 */
#define NVMCTRL_FLMAP_SECTION1_gc  (0x01<<4) /* Flash section 1 */
#define NVMCTRL_FLMAP_SECTION2_gc  (0x02<<4) /* Flash section 2 */
#define NVMCTRL_FLMAP_SECTION3_gc  (0x03<<4)  /* Flash section 3 */
#define PORT_ISC_INTDISABLE_gc  (0x00<<0) /* Interrupt disabled but input buffer enabled */
#define PORT_ISC_BOTHEDGES_gc  (0x01<<0) /* Sense Both Edges */
#define PORT_ISC_RISING_gc  (0x02<<0) /* Sense Rising Edge */
#define PORT_ISC_FALLING_gc  (0x03<<0) /* Sense Falling Edge */
#define PORT_ISC_INPUT_DISABLE_gc  (0x04<<0) /* Digital Input Buffer disabled */
#define PORT_ISC_LEVEL_gc  (0x05<<0)  /* Sense low Level */
#define PORTMUX_EVOUTA_DEFAULT_gc  (0x00<<0) /* EVOUTA: PA2 */
#define PORTMUX_EVOUTA_ALT1_gc  (0x01<<0)  /* EVOUTA: PA7 */
#define PORTMUX_EVOUTC_DEFAULT_gc  (0x00<<2)  /* EVOUTC: PC2 */
#define PORTMUX_EVOUTD_DEFAULT_gc  (0x00<<3) /* EVOUTD: PD2 */
#define PORTMUX_EVOUTD_ALT1_gc  (0x01<<3)  /* EVOUTD: PD7 */
#define PORTMUX_LUT0_DEFAULT_gc  (0x00<<0) /* INn: PA0, PA1, PA2. OUT: PA3. */
#define PORTMUX_LUT0_ALT1_gc  (0x01<<0)  /* INn: PA0, PA1, PA2. OUT: PA6. */
#define PORTMUX_LUT1_DEFAULT_gc  (0x00<<1) /* INn: PC0, PC1, PC2 OUT: PC3 */
#define PORTMUX_LUT1_ALT1_gc  (0x01<<1)  /* INn: PC0, PC1, PC2 OUT: - */
#define PORTMUX_LUT2_DEFAULT_gc  (0x00<<2) /* INn: -, PD1, PD2. OUT: PD3. */
#define PORTMUX_LUT2_ALT1_gc  (0x01<<2)  /* INn: -, PD1, PD2. OUT: PD6. */
#define PORTMUX_LUT3_DEFAULT_gc  (0x00<<3)  /* INn: PF0, PF1, -. OUT: -. */
#define PORTMUX_SPI0_DEFAULT_gc  (0x00<<0) /* MOSI: PA4, MISO: PA5, SCK: PA6, SS: PA7 */
#define PORTMUX_SPI0_ALT3_gc  (0x03<<0) /* MOSI: PA0, MISO: PA1, SCK: PC0, SS: PC1 */
#define PORTMUX_SPI0_ALT4_gc  (0x04<<0) /* MOSI: PD4, MISO: PD5, SCK: PD6, SS: PD7 */
#define PORTMUX_SPI0_ALT5_gc  (0x05<<0) /* MOSI: PC0, MISO: PC1, SCK: PC2, SS: PC3 */
#define PORTMUX_SPI0_ALT6_gc  (0x06<<0) /* MOSI: PC1, MISO: PC2, SCK: PC3, SS: PF7 */
#define PORTMUX_SPI0_NONE_gc  (0x07<<0)  /* Not connected to any pins. SS set to 1. */
#define PORTMUX_TCA0_PORTA_gc  (0x00<<0) /* WOn: PA0, PA1, PA2, PA3, PA4, PA5 */
#define PORTMUX_TCA0_PORTC_gc  (0x02<<0) /* WOn: PC0, PC1, PC2, PC3, -, - */
#define PORTMUX_TCA0_PORTD_gc  (0x03<<0) /* WOn: -, PD1, PD2, PD3, PD4, PD5 */
#define PORTMUX_TCA0_PORTF_gc  (0x05<<0)  /* WOn: PF0, PF1, -, -, -, - */
#define PORTMUX_TCB0_DEFAULT_gc  (0x00<<0)  /* WO: PA2 */
#define PORTMUX_TCB1_DEFAULT_gc  (0x00<<1)  /* WO: PA3 */
#define PORTMUX_TCB2_DEFAULT_gc  (0x00<<2)  /* WO: PC0 */
#define PORTMUX_TCD0_DEFAULT_gc  (0x00<<0) /* WOx: PA4, PA5, PA6, PA7 */
#define PORTMUX_TCD0_ALT2_gc  (0x02<<0) /* WOx: PF0, PF1, -, - */
#define PORTMUX_TCD0_ALT4_gc  (0x04<<0)  /* WOx: PA4, PA5, PD4, PD5 */
#define PORTMUX_TWI0_DEFAULT_gc  (0x00<<0) /* SDA: PA2, SCL: PA3. Dual mode: SDA: PC2, SCL: PC3. */
#define PORTMUX_TWI0_ALT1_gc  (0x01<<0) /* SDA: PA2, SCL: PA3. Dual mode: SDA: -, SCL: -. */
#define PORTMUX_TWI0_ALT2_gc  (0x02<<0) /* SDA: PC2, SCL: PC3. Dual mode: SDA: -, SCL: -. */
#define PORTMUX_TWI0_ALT3_gc  (0x03<<0)  /* SDA: PA0, SCL: PA1. Dual mode: SDA: PC2, SCL: PC3. */
#define PORTMUX_USART0_DEFAULT_gc  (0x00<<0) /* TxD: PA0, RxD: PA1, XCK: PA2, XDIR: PA3 */
#define PORTMUX_USART0_ALT1_gc  (0x01<<0) /* TxD: PA4, RxD: PA5, XCK: PA6, XDIR: PA7 */
#define PORTMUX_USART0_ALT2_gc  (0x02<<0) /* TxD: PA2, RxD: PA3, XCK: -, XDIR: - */
#define PORTMUX_USART0_ALT3_gc  (0x03<<0) /* TxD: PD4, RxD: PD5, XCK: PD6, XDIR: PD7 */
#define PORTMUX_USART0_ALT4_gc  (0x04<<0) /* TxD: PC1, RxD: PC2, XCK: PC3, XDIR: - */
#define PORTMUX_USART0_NONE_gc  (0x05<<0)  /* Not connected to any pins */
#define PORTMUX_USART1_DEFAULT_gc  (0x00<<3) /* TxD: PC0, RxD: PC1, XCK: PC2, XDIR: PC3 */
#define PORTMUX_USART1_ALT2_gc  (0x02<<3) /* TxD: PD6, RxD: PD7, XCK: -, XDIR: - */
#define PORTMUX_USART1_NONE_gc  (0x03<<3)  /* Not connected to any pins */
#define RTC_CLKSEL_OSC32K_gc  (0x00<<0) /* 32.768 kHz from OSC32K */
#define RTC_CLKSEL_OSC1K_gc  (0x01<<0) /* 1.024 kHz from OSC32K */
#define RTC_CLKSEL_XTAL32K_gc  (0x02<<0) /* 32.768 kHz from XOSC32K */
#define RTC_CLKSEL_EXTCLK_gc  (0x03<<0)  /* External Clock */
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
#define SLPCTRL_HTLLEN_OFF_gc  (0x00<<4) /* Disabled */
#define SLPCTRL_HTLLEN_ON_gc  (0x01<<4)  /* Enabled */
#define SLPCTRL_PMODE_AUTO_gc  (0x00<<0) /*  */
#define SLPCTRL_PMODE_FULL_gc  (0x01<<0)  /*  */
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
#define TCA_SINGLE_CLKSEL_DIV1_gc  (0x00<<1) /* CLK_PER */
#define TCA_SINGLE_CLKSEL_DIV2_gc  (0x01<<1) /* CLK_PER / 2 */
#define TCA_SINGLE_CLKSEL_DIV4_gc  (0x02<<1) /* CLK_PER / 4 */
#define TCA_SINGLE_CLKSEL_DIV8_gc  (0x03<<1) /* CLK_PER / 8 */
#define TCA_SINGLE_CLKSEL_DIV16_gc  (0x04<<1) /* CLK_PER / 16 */
#define TCA_SINGLE_CLKSEL_DIV64_gc  (0x05<<1) /* CLK_PER / 64 */
#define TCA_SINGLE_CLKSEL_DIV256_gc  (0x06<<1) /* CLK_PER / 256 */
#define TCA_SINGLE_CLKSEL_DIV1024_gc  (0x07<<1)  /* CLK_PER / 1024 */
#define TCA_SINGLE_CMD_NONE_gc  (0x00<<2) /* No Command */
#define TCA_SINGLE_CMD_UPDATE_gc  (0x01<<2) /* Force Update */
#define TCA_SINGLE_CMD_RESTART_gc  (0x02<<2) /* Force Restart */
#define TCA_SINGLE_CMD_RESET_gc  (0x03<<2)  /* Force Hard Reset */
#define TCA_SINGLE_DIR_UP_gc  (0x00<<0) /* Count up */
#define TCA_SINGLE_DIR_DOWN_gc  (0x01<<0)  /* Count down */
#define TCA_SINGLE_EVACTA_CNT_POSEDGE_gc  (0x00<<1) /* Count on positive edge event */
#define TCA_SINGLE_EVACTA_CNT_ANYEDGE_gc  (0x01<<1) /* Count on any edge event */
#define TCA_SINGLE_EVACTA_CNT_HIGHLVL_gc  (0x02<<1) /* Count on prescaled clock while event line is 1. */
#define TCA_SINGLE_EVACTA_UPDOWN_gc  (0x03<<1)  /* Count on prescaled clock. Event controls count direction. Up-count when event line is 0, down-count when event line is 1. */
#define TCA_SINGLE_EVACTB_NONE_gc  (0x00<<5) /* No Action */
#define TCA_SINGLE_EVACTB_UPDOWN_gc  (0x03<<5) /* Count on prescaled clock. Event controls count direction. Up-count when event line is 0, down-count when event line is 1. */
#define TCA_SINGLE_EVACTB_RESTART_POSEDGE_gc  (0x04<<5) /* Restart counter at positive edge event */
#define TCA_SINGLE_EVACTB_RESTART_ANYEDGE_gc  (0x05<<5) /* Restart counter on any edge event */
#define TCA_SINGLE_EVACTB_RESTART_HIGHLVL_gc  (0x06<<5)  /* Restart counter while event line is 1. */
#define TCA_SINGLE_WGMODE_NORMAL_gc  (0x00<<0) /* Normal Mode */
#define TCA_SINGLE_WGMODE_FRQ_gc  (0x01<<0) /* Frequency Generation Mode */
#define TCA_SINGLE_WGMODE_SINGLESLOPE_gc  (0x03<<0) /* Single Slope PWM */
#define TCA_SINGLE_WGMODE_DSTOP_gc  (0x05<<0) /* Dual Slope PWM, overflow on TOP */
#define TCA_SINGLE_WGMODE_DSBOTH_gc  (0x06<<0) /* Dual Slope PWM, overflow on TOP and BOTTOM */
#define TCA_SINGLE_WGMODE_DSBOTTOM_gc  (0x07<<0)  /* Dual Slope PWM, overflow on BOTTOM */
#define TCA_SPLIT_CLKSEL_DIV1_gc  (0x00<<1) /* CLK_PER */
#define TCA_SPLIT_CLKSEL_DIV2_gc  (0x01<<1) /* CLK_PER / 2 */
#define TCA_SPLIT_CLKSEL_DIV4_gc  (0x02<<1) /* CLK_PER / 4 */
#define TCA_SPLIT_CLKSEL_DIV8_gc  (0x03<<1) /* CLK_PER / 8 */
#define TCA_SPLIT_CLKSEL_DIV16_gc  (0x04<<1) /* CLK_PER / 16 */
#define TCA_SPLIT_CLKSEL_DIV64_gc  (0x05<<1) /* CLK_PER / 64 */
#define TCA_SPLIT_CLKSEL_DIV256_gc  (0x06<<1) /* CLK_PER / 256 */
#define TCA_SPLIT_CLKSEL_DIV1024_gc  (0x07<<1)  /* CLK_PER / 1024 */
#define TCA_SPLIT_CMD_NONE_gc  (0x00<<2) /* No Command */
#define TCA_SPLIT_CMD_RESTART_gc  (0x02<<2) /* Force Restart */
#define TCA_SPLIT_CMD_RESET_gc  (0x03<<2)  /* Force Hard Reset */
#define TCA_SPLIT_CMDEN_NONE_gc  (0x00<<0) /* None */
#define TCA_SPLIT_CMDEN_BOTH_gc  (0x03<<0)  /* Both low byte and high byte counter */
#define TCB_CLKSEL_DIV1_gc  (0x00<<1) /* CLK_PER */
#define TCB_CLKSEL_DIV2_gc  (0x01<<1) /* CLK_PER/2 */
#define TCB_CLKSEL_TCA0_gc  (0x02<<1) /* Use CLK_TCA from TCA0 */
#define TCB_CLKSEL_EVENT_gc  (0x07<<1)  /* Count on event edge */
#define TCB_CNTMODE_INT_gc  (0x00<<0) /* Periodic Interrupt */
#define TCB_CNTMODE_TIMEOUT_gc  (0x01<<0) /* Periodic Timeout */
#define TCB_CNTMODE_CAPT_gc  (0x02<<0) /* Input Capture Event */
#define TCB_CNTMODE_FRQ_gc  (0x03<<0) /* Input Capture Frequency measurement */
#define TCB_CNTMODE_PW_gc  (0x04<<0) /* Input Capture Pulse-Width measurement */
#define TCB_CNTMODE_FRQPW_gc  (0x05<<0) /* Input Capture Frequency and Pulse-Width measurement */
#define TCB_CNTMODE_SINGLE_gc  (0x06<<0) /* Single Shot */
#define TCB_CNTMODE_PWM8_gc  (0x07<<0)  /* 8-bit PWM */
#define TCD_ACTION_FAULT_gc  (0x00<<2) /* Event trigger a fault */
#define TCD_ACTION_CAPTURE_gc  (0x01<<2)  /* Event trigger a fault and capture */
#define TCD_CFG_NEITHER_gc  (0x00<<6) /* Neither Filter nor Asynchronous Event is enabled */
#define TCD_CFG_FILTER_gc  (0x01<<6) /* Input Capture Noise Cancellation Filter enabled */
#define TCD_CFG_ASYNC_gc  (0x02<<6)  /* Asynchronous Event output qualification enabled */
#define TCD_CLKSEL_OSCHF_gc  (0x00<<5) /* Internal High-Frequency oscillator */
#define TCD_CLKSEL_PLL_gc  (0x01<<5) /* PLL */
#define TCD_CLKSEL_EXTCLK_gc  (0x02<<5) /* External clock */
#define TCD_CLKSEL_CLKPER_gc  (0x03<<5)  /* Peripheral Clock */
#define TCD_CMPCSEL_PWMA_gc  (0x00<<6) /* PWM A output */
#define TCD_CMPCSEL_PWMB_gc  (0x01<<6)  /* PWM B output */
#define TCD_CMPDSEL_PWMA_gc  (0x00<<7) /* PWM A output */
#define TCD_CMPDSEL_PWMB_gc  (0x01<<7)  /* PWM B output */
#define TCD_CNTPRES_DIV1_gc  (0x00<<3) /* Sync clock divided by 1 */
#define TCD_CNTPRES_DIV4_gc  (0x01<<3) /* Sync clock divided by 4 */
#define TCD_CNTPRES_DIV32_gc  (0x02<<3)  /* Sync clock divided by 32 */
#define TCD_DITHERSEL_ONTIMEB_gc  (0x00<<0) /* On-time ramp B */
#define TCD_DITHERSEL_ONTIMEAB_gc  (0x01<<0) /* On-time ramp A and B */
#define TCD_DITHERSEL_DEADTIMEB_gc  (0x02<<0) /* Dead-time rampB */
#define TCD_DITHERSEL_DEADTIMEAB_gc  (0x03<<0)  /* Dead-time ramp A and B */
#define TCD_DLYPRESC_DIV1_gc  (0x00<<4) /* No prescaling */
#define TCD_DLYPRESC_DIV2_gc  (0x01<<4) /* Prescale with 2 */
#define TCD_DLYPRESC_DIV4_gc  (0x02<<4) /* Prescale with 4 */
#define TCD_DLYPRESC_DIV8_gc  (0x03<<4)  /* Prescale with 8 */
#define TCD_DLYSEL_OFF_gc  (0x00<<0) /* No delay */
#define TCD_DLYSEL_INBLANK_gc  (0x01<<0) /* Input blanking enabled */
#define TCD_DLYSEL_EVENT_gc  (0x02<<0)  /* Event delay enabled */
#define TCD_DLYTRIG_CMPASET_gc  (0x00<<2) /* Compare A set */
#define TCD_DLYTRIG_CMPACLR_gc  (0x01<<2) /* Compare A clear */
#define TCD_DLYTRIG_CMPBSET_gc  (0x02<<2) /* Compare B set */
#define TCD_DLYTRIG_CMPBCLR_gc  (0x03<<2)  /* Compare B clear */
#define TCD_EDGE_FALL_LOW_gc  (0x00<<4) /* The falling edge or low level of event generates retrigger or fault action */
#define TCD_EDGE_RISE_HIGH_gc  (0x01<<4)  /* The rising edge or high level of event generates retrigger or fault action */
#define TCD_INPUTMODE_NONE_gc  (0x00<<0) /* Input has no actions */
#define TCD_INPUTMODE_JMPWAIT_gc  (0x01<<0) /* Stop output, jump to opposite compare cycle and wait */
#define TCD_INPUTMODE_EXECWAIT_gc  (0x02<<0) /* Stop output, execute opposite compare cycle and wait */
#define TCD_INPUTMODE_EXECFAULT_gc  (0x03<<0) /* stop output, execute opposite compare cycle while fault active */
#define TCD_INPUTMODE_FREQ_gc  (0x04<<0) /* Stop all outputs, maintain frequency */
#define TCD_INPUTMODE_EXECDT_gc  (0x05<<0) /* Stop all outputs, execute dead time while fault active */
#define TCD_INPUTMODE_WAIT_gc  (0x06<<0) /* Stop all outputs, jump to next compare cycle and wait */
#define TCD_INPUTMODE_WAITSW_gc  (0x07<<0) /* Stop all outputs, wait for software action */
#define TCD_INPUTMODE_EDGETRIG_gc  (0x08<<0) /* Stop output on edge, jump to next compare cycle */
#define TCD_INPUTMODE_EDGETRIGFREQ_gc  (0x09<<0) /* Stop output on edge, maintain frequency */
#define TCD_INPUTMODE_LVLTRIGFREQ_gc  (0x0A<<0)  /* Stop output at level, maintain frequency */
#define TCD_SYNCPRES_DIV1_gc  (0x00<<1) /* Selected clock source divided by 1 */
#define TCD_SYNCPRES_DIV2_gc  (0x01<<1) /* Selected clock source divided by 2 */
#define TCD_SYNCPRES_DIV4_gc  (0x02<<1) /* Selected clock source divided by 4 */
#define TCD_SYNCPRES_DIV8_gc  (0x03<<1)  /* Selected clock source divided by 8 */
#define TCD_WGMODE_ONERAMP_gc  (0x00<<0) /* One ramp mode */
#define TCD_WGMODE_TWORAMP_gc  (0x01<<0) /* Two ramp mode */
#define TCD_WGMODE_FOURRAMP_gc  (0x02<<0) /* Four ramp mode */
#define TCD_WGMODE_DS_gc  (0x03<<0)  /* Dual slope mode */
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
#define ZCD_INTMODE_NONE_gc  (0x00<<0) /* No interrupt */
#define ZCD_INTMODE_RISING_gc  (0x01<<0) /* Interrupt on rising input signal */
#define ZCD_INTMODE_FALLING_gc  (0x02<<0) /* Interrupt on falling input signal */
#define ZCD_INTMODE_BOTH_gc  (0x03<<0)  /* Interrupt on both rising and falling input signal */
#define ZCD_STATE_LOW_gc  (0x00<<4) /* Output is 0 */
#define ZCD_STATE_HIGH_gc  (0x01<<4)  /* Output is 1 */
