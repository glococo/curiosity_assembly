#define AC_HYSMODE_OFF_gc  (0x00<<1) /* No hysteresis */
#define AC_HYSMODE_10mV_gc  (0x01<<1) /* 10mV hysteresis */
#define AC_HYSMODE_25mV_gc  (0x02<<1) /* 25mV hysteresis */
#define AC_HYSMODE_50mV_gc  (0x03<<1)  /* 50mV hysteresis */
#define AC_INTMODE_BOTHEDGE_gc  (0x00<<4) /* Both Edge */
#define AC_INTMODE_NEGEDGE_gc  (0x02<<4) /* Negative Edge */
#define AC_INTMODE_POSEDGE_gc  (0x03<<4)  /* Positive Edge */
#define AC_LPMODE_DIS_gc  (0x00<<3) /* Low power mode disabled */
#define AC_LPMODE_EN_gc  (0x01<<3)  /* Low power mode enabled */
#define AC_MUXNEG_AINN0_gc  (0x00<<0) /* Negative Pin 0 */
#define AC_MUXNEG_AINN1_gc  (0x01<<0) /* Negative Pin 1 */
#define AC_MUXNEG_AINN2_gc  (0x02<<0) /* Negative Pin 2 */
#define AC_MUXNEG_DACREF_gc  (0x03<<0)  /* DAC Voltage Reference */
#define AC_MUXPOS_AINP0_gc  (0x00<<3) /* Positive Pin 0 */
#define AC_MUXPOS_AINP1_gc  (0x01<<3) /* Positive Pin 1 */
#define AC_MUXPOS_AINP2_gc  (0x02<<3)  /* Positive Pin 2 */
#define ADC_ADCPGASAMPDUR_6CLK_gc  (0x00<<1) /* 6 ADC cycles */
#define ADC_ADCPGASAMPDUR_15CLK_gc  (0x01<<1) /* 15 ADC cycles */
#define ADC_ADCPGASAMPDUR_20CLK_gc  (0x02<<1)  /* 20 ADC cycles */
#define ADC_GAIN_1X_gc  (0x00<<5) /* 1X Gain */
#define ADC_GAIN_2X_gc  (0x01<<5) /* 2X Gain */
#define ADC_GAIN_4X_gc  (0x02<<5) /* 4X Gain */
#define ADC_GAIN_8X_gc  (0x03<<5) /* 8X Gain */
#define ADC_GAIN_16X_gc  (0x04<<5)  /* 16X Gain */
#define ADC_MODE_SINGLE_8BIT_gc  (0x00<<4) /* Single Conversion 8-bit */
#define ADC_MODE_SINGLE_12BIT_gc  (0x01<<4) /* Single Conversion 12-bit */
#define ADC_MODE_SERIES_gc  (0x02<<4) /* Series Accumulation */
#define ADC_MODE_SERIES_SCALING_gc  (0x03<<4) /* Series Accumulation with Scaling */
#define ADC_MODE_BURST_gc  (0x04<<4) /* Burst Accumulation */
#define ADC_MODE_BURST_SCALING_gc  (0x05<<4)  /* Burst Accumulation with Scaling */
#define ADC_MUXNEG_AIN1_gc  (0x01<<0) /* ADC input pin 1 */
#define ADC_MUXNEG_AIN2_gc  (0x02<<0) /* ADC input pin 2 */
#define ADC_MUXNEG_AIN3_gc  (0x03<<0) /* ADC input pin 3 */
#define ADC_MUXNEG_AIN4_gc  (0x04<<0) /* ADC input pin 4 */
#define ADC_MUXNEG_AIN5_gc  (0x05<<0) /* ADC input pin 5 */
#define ADC_MUXNEG_AIN6_gc  (0x06<<0) /* ADC input pin 6 */
#define ADC_MUXNEG_AIN7_gc  (0x07<<0) /* ADC input pin 7 */
#define ADC_MUXNEG_GND_gc  (0x30<<0) /* Ground */
#define ADC_MUXNEG_VDDDIV10_gc  (0x31<<0) /* VDD/10 */
#define ADC_MUXNEG_DACREF0_gc  (0x33<<0)  /* DACREF from AC0 */
#define ADC_MUXPOS_AIN1_gc  (0x01<<0) /* ADC input pin 1 */
#define ADC_MUXPOS_AIN2_gc  (0x02<<0) /* ADC input pin 2 */
#define ADC_MUXPOS_AIN3_gc  (0x03<<0) /* ADC input pin 3 */
#define ADC_MUXPOS_AIN4_gc  (0x04<<0) /* ADC input pin 4 */
#define ADC_MUXPOS_AIN5_gc  (0x05<<0) /* ADC input pin 5 */
#define ADC_MUXPOS_AIN6_gc  (0x06<<0) /* ADC input pin 6 */
#define ADC_MUXPOS_AIN7_gc  (0x07<<0) /* ADC input pin 7 */
#define ADC_MUXPOS_AIN8_gc  (0x08<<0) /* ADC input pin 8 */
#define ADC_MUXPOS_AIN9_gc  (0x09<<0) /* ADC input pin 9 */
#define ADC_MUXPOS_AIN10_gc  (0x0A<<0) /* ADC input pin 10 */
#define ADC_MUXPOS_AIN11_gc  (0x0B<<0) /* ADC input pin 11 */
#define ADC_MUXPOS_AIN12_gc  (0x0C<<0) /* ADC input pin 12 */
#define ADC_MUXPOS_AIN13_gc  (0x0D<<0) /* ADC input pin 13 */
#define ADC_MUXPOS_AIN14_gc  (0x0E<<0) /* ADC input pin 14 */
#define ADC_MUXPOS_AIN15_gc  (0x0F<<0) /* ADC input pin 15 */
#define ADC_MUXPOS_GND_gc  (0x30<<0) /* Ground */
#define ADC_MUXPOS_VDDDIV10_gc  (0x31<<0) /* VDD/10 */
#define ADC_MUXPOS_TEMPSENSE_gc  (0x32<<0) /* Temperature sensor */
#define ADC_MUXPOS_DACREF0_gc  (0x33<<0)  /* DACREF from AC0 */
#define ADC_PGABIASSEL_1X_gc  (0x00<<3) /* 1x BIAS current */
#define ADC_PGABIASSEL_3_4X_gc  (0x01<<3) /* 3/4x BIAS current */
#define ADC_PGABIASSEL_1_2X_gc  (0x02<<3) /* 1/2x BIAS current */
#define ADC_PGABIASSEL_1_4X_gc  (0x03<<3)  /* 1/4x BIAS current */
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
#define ADC_REFSEL_1024MV_gc  (0x04<<0) /* Internal 1.024V Reference */
#define ADC_REFSEL_2048MV_gc  (0x05<<0) /* Internal 2.048V Reference */
#define ADC_REFSEL_2500MV_gc  (0x06<<0) /* Internal 2.5V Reference */
#define ADC_REFSEL_4096MV_gc  (0x07<<0)  /* Internal 4.096V Reference */
#define ADC_SAMPNUM_NONE_gc  (0x00<<0) /* No accumulation */
#define ADC_SAMPNUM_ACC2_gc  (0x01<<0) /* 2 samples accumulation */
#define ADC_SAMPNUM_ACC4_gc  (0x02<<0) /* 4 samples accumulation */
#define ADC_SAMPNUM_ACC8_gc  (0x03<<0) /* 8 samples accumulation */
#define ADC_SAMPNUM_ACC16_gc  (0x04<<0) /* 16 samples accumulation */
#define ADC_SAMPNUM_ACC32_gc  (0x05<<0) /* 32 samples accumulation */
#define ADC_SAMPNUM_ACC64_gc  (0x06<<0) /* 64 samples accumulation */
#define ADC_SAMPNUM_ACC128_gc  (0x07<<0) /* 128 samples accumulation */
#define ADC_SAMPNUM_ACC256_gc  (0x08<<0) /* 256 samples accumulation */
#define ADC_SAMPNUM_ACC512_gc  (0x09<<0) /* 512 samples accumulation */
#define ADC_SAMPNUM_ACC1024_gc  (0x0A<<0)  /* 1024 samples accumulation */
#define ADC_START_STOP_gc  (0x00<<0) /* Stop an ongoing conversion */
#define ADC_START_IMMEDIATE_gc  (0x01<<0) /* Start immediately */
#define ADC_START_MUXPOS_WRITE_gc  (0x02<<0) /* Start on MUXPOS write */
#define ADC_START_MUXNEG_WRITE_gc  (0x03<<0) /* Start on MUXNEG write */
#define ADC_START_EVENT_TRIGGER_gc  (0x04<<0)  /* Start on event */
#define ADC_VIA_ADC_gc  (0x00<<6) /* Via ADC */
#define ADC_VIA_PGA_gc  (0x01<<6)  /* Via PGA */
#define ADC_WINCM_NONE_gc  (0x00<<0) /* No Window Comparison */
#define ADC_WINCM_BELOW_gc  (0x01<<0) /* Below Window */
#define ADC_WINCM_ABOVE_gc  (0x02<<0) /* Above Window */
#define ADC_WINCM_INSIDE_gc  (0x03<<0) /* Inside Window */
#define ADC_WINCM_OUTSIDE_gc  (0x04<<0)  /* Outside Window */
#define ADC_WINSRC_RESULT_gc  (0x00<<3) /* Result register */
#define ADC_WINSRC_SAMPLE_gc  (0x01<<3)  /* Sample register */
#define BOD_ACTIVE_DIS_gc  (0x00<<2) /* Disabled */
#define BOD_ACTIVE_ENABLED_gc  (0x01<<2) /* Enabled */
#define BOD_ACTIVE_SAMPLED_gc  (0x02<<2) /* Sampled */
#define BOD_ACTIVE_ENWAKE_gc  (0x03<<2)  /* Enabled with wake-up halted until BOD is ready */
#define BOD_LVL_BODLEVEL0_gc  (0x00<<0) /* 1.8 V */
#define BOD_LVL_BODLEVEL2_gc  (0x02<<0) /* 2.6 V */
#define BOD_LVL_BODLEVEL7_gc  (0x07<<0)  /* 4.2 V */
#define BOD_SAMPFREQ_1KHZ_gc  (0x00<<4) /* 1kHz sampling frequency */
#define BOD_SAMPFREQ_125HZ_gc  (0x01<<4)  /* 125Hz sampling frequency */
#define BOD_SLEEP_DIS_gc  (0x00<<0) /* Disabled */
#define BOD_SLEEP_ENABLED_gc  (0x01<<0) /* Enabled */
#define BOD_SLEEP_SAMPLED_gc  (0x02<<0)  /* Sampled */
#define BOD_VLMCFG_BELOW_gc  (0x00<<1) /* Interrupt when supply goes below VLM level */
#define BOD_VLMCFG_ABOVE_gc  (0x01<<1) /* Interrupt when supply goes above VLM level */
#define BOD_VLMCFG_CROSS_gc  (0x02<<1)  /* Interrupt when supply crosses VLM level */
#define BOD_VLMLVL_5ABOVE_gc  (0x00<<0) /* VLM threshold 5% above BOD level */
#define BOD_VLMLVL_15ABOVE_gc  (0x01<<0) /* VLM threshold 15% above BOD level */
#define BOD_VLMLVL_25ABOVE_gc  (0x02<<0)  /* VLM threshold 25% above BOD level */
#define CCL_CLKSRC_CLKPER_gc  (0x00<<1) /* CLK_PER is clocking the LUT */
#define CCL_CLKSRC_IN2_gc  (0x01<<1) /* IN[2] is clocking the LUT */
#define CCL_CLKSRC_OSC20M_gc  (0x04<<1) /* 20MHz oscillator before prescaler is clocking the LUT */
#define CCL_CLKSRC_OSCULP32K_gc  (0x05<<1) /* 32kHz oscillator is clocking the LUT */
#define CCL_CLKSRC_OSCULP1K_gc  (0x06<<1)  /* 32kHz oscillator after DIV32 is clocking the LUT */
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
#define CCL_INSEL0_IO_gc  (0x05<<0) /* IO pin LUTn-IN0 input source */
#define CCL_INSEL0_AC0_gc  (0x06<<0) /* AC0 OUT input source */
#define CCL_INSEL0_USART0_gc  (0x08<<0) /* USART0 TXD input source */
#define CCL_INSEL0_SPI0_gc  (0x09<<0) /* SPI0 MOSI input source */
#define CCL_INSEL0_TCA0_gc  (0x0A<<0) /* TCA0 WO0 input source */
#define CCL_INSEL0_TCB0_gc  (0x0C<<0)  /* TCB0 WO input source */
#define CCL_INSEL1_MASK_gc  (0x00<<4) /* Masked input */
#define CCL_INSEL1_FEEDBACK_gc  (0x01<<4) /* Feedback input source */
#define CCL_INSEL1_LINK_gc  (0x02<<4) /* Linked LUT input source */
#define CCL_INSEL1_EVENTA_gc  (0x03<<4) /* Event input source A */
#define CCL_INSEL1_EVENTB_gc  (0x04<<4) /* Event input source B */
#define CCL_INSEL1_IO_gc  (0x05<<4) /* IO pin LUTn-IN1 input source */
#define CCL_INSEL1_AC0_gc  (0x06<<4) /* AC0 OUT input source */
#define CCL_INSEL1_USART1_gc  (0x08<<4) /* USART1 TXD input source */
#define CCL_INSEL1_SPI0_gc  (0x09<<4) /* SPI0 MOSI input source */
#define CCL_INSEL1_TCA0_gc  (0x0A<<4) /* TCA0 WO1 input source */
#define CCL_INSEL1_TCB1_gc  (0x0C<<4)  /* TCB1 WO input source */
#define CCL_INSEL2_MASK_gc  (0x00<<0) /* Masked input */
#define CCL_INSEL2_FEEDBACK_gc  (0x01<<0) /* Feedback input source */
#define CCL_INSEL2_LINK_gc  (0x02<<0) /* Linked LUT input source */
#define CCL_INSEL2_EVENTA_gc  (0x03<<0) /* Event input source A */
#define CCL_INSEL2_EVENTB_gc  (0x04<<0) /* Event input source B */
#define CCL_INSEL2_IO_gc  (0x05<<0) /* IO pin LUTn-IN2 input source */
#define CCL_INSEL2_AC0_gc  (0x06<<0) /* AC0 OUT input source */
#define CCL_INSEL2_SPI0_gc  (0x09<<0) /* SPI0 SCK input source */
#define CCL_INSEL2_TCA0_gc  (0x0A<<0)  /* TCA0 WO2 input source */
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
#define CLKCTRL_CLKSEL_OSC20M_gc  (0x00<<0) /* 20MHz oscillator */
#define CLKCTRL_CLKSEL_OSCULP32K_gc  (0x01<<0) /* 32KHz oscillator */
#define CLKCTRL_CLKSEL_XOSC32K_gc  (0x02<<0) /* 32.768kHz crystal oscillator */
#define CLKCTRL_CLKSEL_EXTCLK_gc  (0x03<<0)  /* External clock */
#define CLKCTRL_CSUT_1K_gc  (0x00<<4) /* 1k cycles */
#define CLKCTRL_CSUT_16K_gc  (0x01<<4) /* 16k cycles */
#define CLKCTRL_CSUT_32K_gc  (0x02<<4) /* 32k cycles */
#define CLKCTRL_CSUT_64K_gc  (0x03<<4)  /* 64k cycles */
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
#define CCP_SPM_gc  (0x9D<<0) /* SPM Instruction Protection */
#define CCP_IOREG_gc  (0xD8<<0)  /* IO Register Protection */
#define CRCSCAN_MODE_PRIORITY_gc  (0x00<<4)  /* Priority to flash */
#define CRCSCAN_SRC_FLASH_gc  (0x00<<0) /* CRC on entire flash */
#define CRCSCAN_SRC_APPLICATION_gc  (0x01<<0) /* CRC on boot and appl section of flash */
#define CRCSCAN_SRC_BOOT_gc  (0x02<<0)  /* CRC on boot section of flash */
#define EVSYS_CHANNEL0_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_CHANNEL0_UPDI_gc  (0x01<<0) /* Unified Program and Debug Interface */
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
#define EVSYS_CHANNEL0_ADC0_RES_gc  (0x24<<0) /* ADC 0 Result ready event */
#define EVSYS_CHANNEL0_ADC0_SAMP_gc  (0x25<<0) /* ADC 0 Sample ready event */
#define EVSYS_CHANNEL0_ADC0_WCMP_gc  (0x26<<0) /* ADC 0 Window compare match event */
#define EVSYS_CHANNEL0_PORTA_PIN0_gc  (0x40<<0) /* Port A Pin 0 */
#define EVSYS_CHANNEL0_PORTA_PIN1_gc  (0x41<<0) /* Port A Pin 1 */
#define EVSYS_CHANNEL0_PORTA_PIN2_gc  (0x42<<0) /* Port A Pin 2 */
#define EVSYS_CHANNEL0_PORTA_PIN3_gc  (0x43<<0) /* Port A Pin 3 */
#define EVSYS_CHANNEL0_PORTA_PIN4_gc  (0x44<<0) /* Port A Pin 4 */
#define EVSYS_CHANNEL0_PORTA_PIN5_gc  (0x45<<0) /* Port A Pin 5 */
#define EVSYS_CHANNEL0_PORTA_PIN6_gc  (0x46<<0) /* Port A Pin 6 */
#define EVSYS_CHANNEL0_PORTA_PIN7_gc  (0x47<<0) /* Port A Pin 7 */
#define EVSYS_CHANNEL0_PORTB_PIN0_gc  (0x48<<0) /* Port B Pin 0 */
#define EVSYS_CHANNEL0_PORTB_PIN1_gc  (0x49<<0) /* Port B Pin 1 */
#define EVSYS_CHANNEL0_PORTB_PIN2_gc  (0x4A<<0) /* Port B Pin 2 */
#define EVSYS_CHANNEL0_PORTB_PIN3_gc  (0x4B<<0) /* Port B Pin 3 */
#define EVSYS_CHANNEL0_PORTB_PIN4_gc  (0x4C<<0) /* Port B Pin 4 */
#define EVSYS_CHANNEL0_PORTB_PIN5_gc  (0x4D<<0) /* Port B Pin 5 */
#define EVSYS_CHANNEL0_USART0_XCK_gc  (0x60<<0) /* USART 0 XCK */
#define EVSYS_CHANNEL0_USART1_XCK_gc  (0x61<<0) /* USART 1 XCK */
#define EVSYS_CHANNEL0_SPI0_SCK_gc  (0x68<<0) /* SPI 0 Sclock */
#define EVSYS_CHANNEL0_TCA0_OVF_LUNF_gc  (0x80<<0) /* Timer/Counter A0 overflow / low byte underflow */
#define EVSYS_CHANNEL0_TCA0_HUNF_gc  (0x81<<0) /* Timer/Counter A0 high byte underflow */
#define EVSYS_CHANNEL0_TCA0_CMP0_LCMP0_gc  (0x84<<0) /* Timer/Counter A0 compare 0 / low byte timer compare 0 */
#define EVSYS_CHANNEL0_TCA0_CMP1_LCMP1_gc  (0x85<<0) /* Timer/Counter A0 compare 1 / low byte timer compare 1 */
#define EVSYS_CHANNEL0_TCA0_CMP2_LCMP2_gc  (0x86<<0) /* Timer/Counter A0 compare 2 / low byte timer compare 2 */
#define EVSYS_CHANNEL0_TCB0_CAPT_gc  (0xA0<<0) /* Timer/Counter B0 capture */
#define EVSYS_CHANNEL0_TCB0_OVF_gc  (0xA1<<0) /* Timer/Counter B0 overflow */
#define EVSYS_CHANNEL0_TCB1_CAPT_gc  (0xA2<<0) /* Timer/Counter B1 capture */
#define EVSYS_CHANNEL0_TCB1_OVF_gc  (0xA3<<0)  /* Timer/Counter B1 overflow */
#define EVSYS_CHANNEL1_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_CHANNEL1_UPDI_gc  (0x01<<0) /* Unified Program and Debug Interface */
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
#define EVSYS_CHANNEL1_ADC0_RES_gc  (0x24<<0) /* ADC 0 Result ready event */
#define EVSYS_CHANNEL1_ADC0_SAMP_gc  (0x25<<0) /* ADC 0 Sample ready event */
#define EVSYS_CHANNEL1_ADC0_WCMP_gc  (0x26<<0) /* ADC 0 Window compare match event */
#define EVSYS_CHANNEL1_PORTA_PIN0_gc  (0x40<<0) /* Port A Pin 0 */
#define EVSYS_CHANNEL1_PORTA_PIN1_gc  (0x41<<0) /* Port A Pin 1 */
#define EVSYS_CHANNEL1_PORTA_PIN2_gc  (0x42<<0) /* Port A Pin 2 */
#define EVSYS_CHANNEL1_PORTA_PIN3_gc  (0x43<<0) /* Port A Pin 3 */
#define EVSYS_CHANNEL1_PORTA_PIN4_gc  (0x44<<0) /* Port A Pin 4 */
#define EVSYS_CHANNEL1_PORTA_PIN5_gc  (0x45<<0) /* Port A Pin 5 */
#define EVSYS_CHANNEL1_PORTA_PIN6_gc  (0x46<<0) /* Port A Pin 6 */
#define EVSYS_CHANNEL1_PORTA_PIN7_gc  (0x47<<0) /* Port A Pin 7 */
#define EVSYS_CHANNEL1_PORTB_PIN0_gc  (0x48<<0) /* Port B Pin 0 */
#define EVSYS_CHANNEL1_PORTB_PIN1_gc  (0x49<<0) /* Port B Pin 1 */
#define EVSYS_CHANNEL1_PORTB_PIN2_gc  (0x4A<<0) /* Port B Pin 2 */
#define EVSYS_CHANNEL1_PORTB_PIN3_gc  (0x4B<<0) /* Port B Pin 3 */
#define EVSYS_CHANNEL1_PORTB_PIN4_gc  (0x4C<<0) /* Port B Pin 4 */
#define EVSYS_CHANNEL1_PORTB_PIN5_gc  (0x4D<<0) /* Port B Pin 5 */
#define EVSYS_CHANNEL1_USART0_XCK_gc  (0x60<<0) /* USART 0 XCK */
#define EVSYS_CHANNEL1_USART1_XCK_gc  (0x61<<0) /* USART 1 XCK */
#define EVSYS_CHANNEL1_SPI0_SCK_gc  (0x68<<0) /* SPI 0 Sclock */
#define EVSYS_CHANNEL1_TCA0_OVF_LUNF_gc  (0x80<<0) /* Timer/Counter A0 overflow / low byte underflow */
#define EVSYS_CHANNEL1_TCA0_HUNF_gc  (0x81<<0) /* Timer/Counter A0 high byte underflow */
#define EVSYS_CHANNEL1_TCA0_CMP0_LCMP0_gc  (0x84<<0) /* Timer/Counter A0 compare 0 / low byte timer compare 0 */
#define EVSYS_CHANNEL1_TCA0_CMP1_LCMP1_gc  (0x85<<0) /* Timer/Counter A0 compare 1 / low byte timer compare 1 */
#define EVSYS_CHANNEL1_TCA0_CMP2_LCMP2_gc  (0x86<<0) /* Timer/Counter A0 compare 2 / low byte timer compare 2 */
#define EVSYS_CHANNEL1_TCB0_CAPT_gc  (0xA0<<0) /* Timer/Counter B0 capture */
#define EVSYS_CHANNEL1_TCB0_OVF_gc  (0xA1<<0) /* Timer/Counter B0 overflow */
#define EVSYS_CHANNEL1_TCB1_CAPT_gc  (0xA2<<0) /* Timer/Counter B1 capture */
#define EVSYS_CHANNEL1_TCB1_OVF_gc  (0xA3<<0)  /* Timer/Counter B1 overflow */
#define EVSYS_CHANNEL2_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_CHANNEL2_UPDI_gc  (0x01<<0) /* Unified Program and Debug Interface */
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
#define EVSYS_CHANNEL2_ADC0_RES_gc  (0x24<<0) /* ADC 0 Result ready event */
#define EVSYS_CHANNEL2_ADC0_SAMP_gc  (0x25<<0) /* ADC 0 Sample ready event */
#define EVSYS_CHANNEL2_ADC0_WCMP_gc  (0x26<<0) /* ADC 0 Window compare match event */
#define EVSYS_CHANNEL2_PORTC_PIN0_gc  (0x40<<0) /* Port C Pin 0 */
#define EVSYS_CHANNEL2_PORTC_PIN1_gc  (0x41<<0) /* Port C Pin 1 */
#define EVSYS_CHANNEL2_PORTC_PIN2_gc  (0x42<<0) /* Port C Pin 2 */
#define EVSYS_CHANNEL2_PORTC_PIN3_gc  (0x43<<0) /* Port C Pin 3 */
#define EVSYS_CHANNEL2_PORTA_PIN0_gc  (0x48<<0) /* Port A Pin 0 */
#define EVSYS_CHANNEL2_PORTA_PIN1_gc  (0x49<<0) /* Port A Pin 1 */
#define EVSYS_CHANNEL2_PORTA_PIN2_gc  (0x4A<<0) /* Port A Pin 2 */
#define EVSYS_CHANNEL2_PORTA_PIN3_gc  (0x4B<<0) /* Port A Pin 3 */
#define EVSYS_CHANNEL2_PORTA_PIN4_gc  (0x4C<<0) /* Port A Pin 4 */
#define EVSYS_CHANNEL2_PORTA_PIN5_gc  (0x4D<<0) /* Port A Pin 5 */
#define EVSYS_CHANNEL2_PORTA_PIN6_gc  (0x4E<<0) /* Port A Pin 6 */
#define EVSYS_CHANNEL2_PORTA_PIN7_gc  (0x4F<<0) /* Port A Pin 7 */
#define EVSYS_CHANNEL2_USART0_XCK_gc  (0x60<<0) /* USART 0 XCK */
#define EVSYS_CHANNEL2_USART1_XCK_gc  (0x61<<0) /* USART 1 XCK */
#define EVSYS_CHANNEL2_SPI0_SCK_gc  (0x68<<0) /* SPI 0 Sclock */
#define EVSYS_CHANNEL2_TCA0_OVF_LUNF_gc  (0x80<<0) /* Timer/Counter A0 overflow / low byte underflow */
#define EVSYS_CHANNEL2_TCA0_HUNF_gc  (0x81<<0) /* Timer/Counter A0 high byte underflow */
#define EVSYS_CHANNEL2_TCA0_CMP0_LCMP0_gc  (0x84<<0) /* Timer/Counter A0 compare 0 / low byte timer compare 0 */
#define EVSYS_CHANNEL2_TCA0_CMP1_LCMP1_gc  (0x85<<0) /* Timer/Counter A0 compare 1 / low byte timer compare 1 */
#define EVSYS_CHANNEL2_TCA0_CMP2_LCMP2_gc  (0x86<<0) /* Timer/Counter A0 compare 2 / low byte timer compare 2 */
#define EVSYS_CHANNEL2_TCB0_CAPT_gc  (0xA0<<0) /* Timer/Counter B0 capture */
#define EVSYS_CHANNEL2_TCB0_OVF_gc  (0xA1<<0) /* Timer/Counter B0 overflow */
#define EVSYS_CHANNEL2_TCB1_CAPT_gc  (0xA2<<0) /* Timer/Counter B1 capture */
#define EVSYS_CHANNEL2_TCB1_OVF_gc  (0xA3<<0)  /* Timer/Counter B1 overflow */
#define EVSYS_CHANNEL3_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_CHANNEL3_UPDI_gc  (0x01<<0) /* Unified Program and Debug Interface */
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
#define EVSYS_CHANNEL3_ADC0_RES_gc  (0x24<<0) /* ADC 0 Result ready event */
#define EVSYS_CHANNEL3_ADC0_SAMP_gc  (0x25<<0) /* ADC 0 Sample ready event */
#define EVSYS_CHANNEL3_ADC0_WCMP_gc  (0x26<<0) /* ADC 0 Window compare match event */
#define EVSYS_CHANNEL3_PORTC_PIN0_gc  (0x40<<0) /* Port C Pin 0 */
#define EVSYS_CHANNEL3_PORTC_PIN1_gc  (0x41<<0) /* Port C Pin 1 */
#define EVSYS_CHANNEL3_PORTC_PIN2_gc  (0x42<<0) /* Port C Pin 2 */
#define EVSYS_CHANNEL3_PORTC_PIN3_gc  (0x43<<0) /* Port C Pin 3 */
#define EVSYS_CHANNEL3_PORTA_PIN0_gc  (0x48<<0) /* Port A Pin 0 */
#define EVSYS_CHANNEL3_PORTA_PIN1_gc  (0x49<<0) /* Port A Pin 1 */
#define EVSYS_CHANNEL3_PORTA_PIN2_gc  (0x4A<<0) /* Port A Pin 2 */
#define EVSYS_CHANNEL3_PORTA_PIN3_gc  (0x4B<<0) /* Port A Pin 3 */
#define EVSYS_CHANNEL3_PORTA_PIN4_gc  (0x4C<<0) /* Port A Pin 4 */
#define EVSYS_CHANNEL3_PORTA_PIN5_gc  (0x4D<<0) /* Port A Pin 5 */
#define EVSYS_CHANNEL3_PORTA_PIN6_gc  (0x4E<<0) /* Port A Pin 6 */
#define EVSYS_CHANNEL3_PORTA_PIN7_gc  (0x4F<<0) /* Port A Pin 7 */
#define EVSYS_CHANNEL3_USART0_XCK_gc  (0x60<<0) /* USART 0 XCK */
#define EVSYS_CHANNEL3_USART1_XCK_gc  (0x61<<0) /* USART 1 XCK */
#define EVSYS_CHANNEL3_SPI0_SCK_gc  (0x68<<0) /* SPI 0 Sclock */
#define EVSYS_CHANNEL3_TCA0_OVF_LUNF_gc  (0x80<<0) /* Timer/Counter A0 overflow / low byte underflow */
#define EVSYS_CHANNEL3_TCA0_HUNF_gc  (0x81<<0) /* Timer/Counter A0 high byte underflow */
#define EVSYS_CHANNEL3_TCA0_CMP0_LCMP0_gc  (0x84<<0) /* Timer/Counter A0 compare 0 / low byte timer compare 0 */
#define EVSYS_CHANNEL3_TCA0_CMP1_LCMP1_gc  (0x85<<0) /* Timer/Counter A0 compare 1 / low byte timer compare 1 */
#define EVSYS_CHANNEL3_TCA0_CMP2_LCMP2_gc  (0x86<<0) /* Timer/Counter A0 compare 2 / low byte timer compare 2 */
#define EVSYS_CHANNEL3_TCB0_CAPT_gc  (0xA0<<0) /* Timer/Counter B0 capture */
#define EVSYS_CHANNEL3_TCB0_OVF_gc  (0xA1<<0) /* Timer/Counter B0 overflow */
#define EVSYS_CHANNEL3_TCB1_CAPT_gc  (0xA2<<0) /* Timer/Counter B1 capture */
#define EVSYS_CHANNEL3_TCB1_OVF_gc  (0xA3<<0)  /* Timer/Counter B1 overflow */
#define EVSYS_CHANNEL4_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_CHANNEL4_UPDI_gc  (0x01<<0) /* Unified Program and Debug Interface */
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
#define EVSYS_CHANNEL4_ADC0_RES_gc  (0x24<<0) /* ADC 0 Result ready event */
#define EVSYS_CHANNEL4_ADC0_SAMP_gc  (0x25<<0) /* ADC 0 Sample ready event */
#define EVSYS_CHANNEL4_ADC0_WCMP_gc  (0x26<<0) /* ADC 0 Window compare match event */
#define EVSYS_CHANNEL4_PORTB_PIN0_gc  (0x40<<0) /* Port B Pin 0 */
#define EVSYS_CHANNEL4_PORTB_PIN1_gc  (0x41<<0) /* Port B Pin 1 */
#define EVSYS_CHANNEL4_PORTB_PIN2_gc  (0x42<<0) /* Port B Pin 2 */
#define EVSYS_CHANNEL4_PORTB_PIN3_gc  (0x43<<0) /* Port B Pin 3 */
#define EVSYS_CHANNEL4_PORTB_PIN4_gc  (0x44<<0) /* Port B Pin 4 */
#define EVSYS_CHANNEL4_PORTB_PIN5_gc  (0x45<<0) /* Port B Pin 5 */
#define EVSYS_CHANNEL4_PORTC_PIN0_gc  (0x48<<0) /* Port C Pin 0 */
#define EVSYS_CHANNEL4_PORTC_PIN1_gc  (0x49<<0) /* Port C Pin 1 */
#define EVSYS_CHANNEL4_PORTC_PIN2_gc  (0x4A<<0) /* Port C Pin 2 */
#define EVSYS_CHANNEL4_PORTC_PIN3_gc  (0x4B<<0) /* Port C Pin 3 */
#define EVSYS_CHANNEL4_USART0_XCK_gc  (0x60<<0) /* USART 0 XCK */
#define EVSYS_CHANNEL4_USART1_XCK_gc  (0x61<<0) /* USART 1 XCK */
#define EVSYS_CHANNEL4_SPI0_SCK_gc  (0x68<<0) /* SPI 0 Sclock */
#define EVSYS_CHANNEL4_TCA0_OVF_LUNF_gc  (0x80<<0) /* Timer/Counter A0 overflow / low byte underflow */
#define EVSYS_CHANNEL4_TCA0_HUNF_gc  (0x81<<0) /* Timer/Counter A0 high byte underflow */
#define EVSYS_CHANNEL4_TCA0_CMP0_LCMP0_gc  (0x84<<0) /* Timer/Counter A0 compare 0 / low byte timer compare 0 */
#define EVSYS_CHANNEL4_TCA0_CMP1_LCMP1_gc  (0x85<<0) /* Timer/Counter A0 compare 1 / low byte timer compare 1 */
#define EVSYS_CHANNEL4_TCA0_CMP2_LCMP2_gc  (0x86<<0) /* Timer/Counter A0 compare 2 / low byte timer compare 2 */
#define EVSYS_CHANNEL4_TCB0_CAPT_gc  (0xA0<<0) /* Timer/Counter B0 capture */
#define EVSYS_CHANNEL4_TCB0_OVF_gc  (0xA1<<0) /* Timer/Counter B0 overflow */
#define EVSYS_CHANNEL4_TCB1_CAPT_gc  (0xA2<<0) /* Timer/Counter B1 capture */
#define EVSYS_CHANNEL4_TCB1_OVF_gc  (0xA3<<0)  /* Timer/Counter B1 overflow */
#define EVSYS_CHANNEL5_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_CHANNEL5_UPDI_gc  (0x01<<0) /* Unified Program and Debug Interface */
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
#define EVSYS_CHANNEL5_ADC0_RES_gc  (0x24<<0) /* ADC 0 Result ready event */
#define EVSYS_CHANNEL5_ADC0_SAMP_gc  (0x25<<0) /* ADC 0 Sample ready event */
#define EVSYS_CHANNEL5_ADC0_WCMP_gc  (0x26<<0) /* ADC 0 Window compare match event */
#define EVSYS_CHANNEL5_PORTB_PIN0_gc  (0x40<<0) /* Port B Pin 0 */
#define EVSYS_CHANNEL5_PORTB_PIN1_gc  (0x41<<0) /* Port B Pin 1 */
#define EVSYS_CHANNEL5_PORTB_PIN2_gc  (0x42<<0) /* Port B Pin 2 */
#define EVSYS_CHANNEL5_PORTB_PIN3_gc  (0x43<<0) /* Port B Pin 3 */
#define EVSYS_CHANNEL5_PORTB_PIN4_gc  (0x44<<0) /* Port B Pin 4 */
#define EVSYS_CHANNEL5_PORTB_PIN5_gc  (0x45<<0) /* Port B Pin 5 */
#define EVSYS_CHANNEL5_PORTC_PIN0_gc  (0x48<<0) /* Port C Pin 0 */
#define EVSYS_CHANNEL5_PORTC_PIN1_gc  (0x49<<0) /* Port C Pin 1 */
#define EVSYS_CHANNEL5_PORTC_PIN2_gc  (0x4A<<0) /* Port C Pin 2 */
#define EVSYS_CHANNEL5_PORTC_PIN3_gc  (0x4B<<0) /* Port C Pin 3 */
#define EVSYS_CHANNEL5_USART0_XCK_gc  (0x60<<0) /* USART 0 XCK */
#define EVSYS_CHANNEL5_USART1_XCK_gc  (0x61<<0) /* USART 1 XCK */
#define EVSYS_CHANNEL5_SPI0_SCK_gc  (0x68<<0) /* SPI 0 Sclock */
#define EVSYS_CHANNEL5_TCA0_OVF_LUNF_gc  (0x80<<0) /* Timer/Counter A0 overflow / low byte underflow */
#define EVSYS_CHANNEL5_TCA0_HUNF_gc  (0x81<<0) /* Timer/Counter A0 high byte underflow */
#define EVSYS_CHANNEL5_TCA0_CMP0_LCMP0_gc  (0x84<<0) /* Timer/Counter A0 compare 0 / low byte timer compare 0 */
#define EVSYS_CHANNEL5_TCA0_CMP1_LCMP1_gc  (0x85<<0) /* Timer/Counter A0 compare 1 / low byte timer compare 1 */
#define EVSYS_CHANNEL5_TCA0_CMP2_LCMP2_gc  (0x86<<0) /* Timer/Counter A0 compare 2 / low byte timer compare 2 */
#define EVSYS_CHANNEL5_TCB0_CAPT_gc  (0xA0<<0) /* Timer/Counter B0 capture */
#define EVSYS_CHANNEL5_TCB0_OVF_gc  (0xA1<<0) /* Timer/Counter B0 overflow */
#define EVSYS_CHANNEL5_TCB1_CAPT_gc  (0xA2<<0) /* Timer/Counter B1 capture */
#define EVSYS_CHANNEL5_TCB1_OVF_gc  (0xA3<<0)  /* Timer/Counter B1 overflow */
#define EVSYS_SWEVENTA_CH0_gc  (0x01<<0) /* Software event on channel 0 */
#define EVSYS_SWEVENTA_CH1_gc  (0x02<<0) /* Software event on channel 1 */
#define EVSYS_SWEVENTA_CH2_gc  (0x04<<0) /* Software event on channel 2 */
#define EVSYS_SWEVENTA_CH3_gc  (0x08<<0) /* Software event on channel 3 */
#define EVSYS_SWEVENTA_CH4_gc  (0x10<<0) /* Software event on channel 4 */
#define EVSYS_SWEVENTA_CH5_gc  (0x20<<0)  /* Software event on channel 5 */
#define EVSYS_USER_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_USER_CHANNEL0_gc  (0x01<<0) /* Connect user to event channel 0 */
#define EVSYS_USER_CHANNEL1_gc  (0x02<<0) /* Connect user to event channel 1 */
#define EVSYS_USER_CHANNEL2_gc  (0x03<<0) /* Connect user to event channel 2 */
#define EVSYS_USER_CHANNEL3_gc  (0x04<<0) /* Connect user to event channel 3 */
#define EVSYS_USER_CHANNEL4_gc  (0x05<<0) /* Connect user to event channel 4 */
#define EVSYS_USER_CHANNEL5_gc  (0x06<<0)  /* Connect user to event channel 5 */
#define ACTIVE_DIS_gc  (0x00<<2) /* Disabled */
#define ACTIVE_ENABLED_gc  (0x01<<2) /* Enabled */
#define ACTIVE_SAMPLED_gc  (0x02<<2) /* Sampled */
#define ACTIVE_ENWAKE_gc  (0x03<<2)  /* Enabled with wake-up halted until BOD is ready */
#define CRCSRC_FLASH_gc  (0x00<<6) /* The CRC is performed on the entire Flash (boot, application code and application data section). */
#define CRCSRC_BOOT_gc  (0x01<<6) /* The CRC is performed on the boot section of Flash */
#define CRCSRC_BOOTAPP_gc  (0x02<<6) /* The CRC is performed on the boot and application code section of Flash */
#define CRCSRC_NOCRC_gc  (0x03<<6)  /* Disable CRC. */
#define FREQSEL_16MHZ_gc  (0x01<<0) /* 16 MHz */
#define FREQSEL_20MHZ_gc  (0x02<<0)  /* 20 MHz */
#define LVL_BODLEVEL0_gc  (0x00<<5) /* 1.8 V */
#define LVL_BODLEVEL2_gc  (0x02<<5) /* 2.6 V */
#define LVL_BODLEVEL7_gc  (0x07<<5)  /* 4.2 V */
#define PERIOD_OFF_gc  (0x00<<0) /* Off */
#define PERIOD_8CLK_gc  (0x01<<0) /* 8 cycles (8ms) */
#define PERIOD_16CLK_gc  (0x02<<0) /* 16 cycles (16ms) */
#define PERIOD_32CLK_gc  (0x03<<0) /* 32 cycles (32ms) */
#define PERIOD_64CLK_gc  (0x04<<0) /* 64 cycles (64ms) */
#define PERIOD_128CLK_gc  (0x05<<0) /* 128 cycles (0.128s) */
#define PERIOD_256CLK_gc  (0x06<<0) /* 256 cycles (0.256s) */
#define PERIOD_512CLK_gc  (0x07<<0) /* 512 cycles (0.512s) */
#define PERIOD_1KCLK_gc  (0x08<<0) /* 1K cycles (1.0s) */
#define PERIOD_2KCLK_gc  (0x09<<0) /* 2K cycles (2.0s) */
#define PERIOD_4KCLK_gc  (0x0A<<0) /* 4K cycles (4.1s) */
#define PERIOD_8KCLK_gc  (0x0B<<0)  /* 8K cycles (8.2s) */
#define RSTPINCFG_GPIO_gc  (0x00<<2) /* GPIO mode */
#define RSTPINCFG_UPDI_gc  (0x01<<2) /* UPDI mode */
#define RSTPINCFG_RST_gc  (0x02<<2) /* Reset mode */
#define RSTPINCFG_PDIRST_gc  (0x03<<2)  /* PDI on PDI pad, reset on alternative reset pad */
#define SAMPFREQ_1KHZ_gc  (0x00<<4) /* 1kHz sampling frequency */
#define SAMPFREQ_125HZ_gc  (0x01<<4)  /* 125Hz sampling frequency */
#define SLEEP_DIS_gc  (0x00<<0) /* Disabled */
#define SLEEP_ENABLED_gc  (0x01<<0) /* Enabled */
#define SLEEP_SAMPLED_gc  (0x02<<0)  /* Sampled */
#define SUT_0MS_gc  (0x00<<0) /* 0 ms */
#define SUT_1MS_gc  (0x01<<0) /* 1 ms */
#define SUT_2MS_gc  (0x02<<0) /* 2 ms */
#define SUT_4MS_gc  (0x03<<0) /* 4 ms */
#define SUT_8MS_gc  (0x04<<0) /* 8 ms */
#define SUT_16MS_gc  (0x05<<0) /* 16 ms */
#define SUT_32MS_gc  (0x06<<0) /* 32 ms */
#define SUT_64MS_gc  (0x07<<0)  /* 64 ms */
#define WINDOW_OFF_gc  (0x00<<4) /* Off */
#define WINDOW_8CLK_gc  (0x01<<4) /* 8 cycles (8ms) */
#define WINDOW_16CLK_gc  (0x02<<4) /* 16 cycles (16ms) */
#define WINDOW_32CLK_gc  (0x03<<4) /* 32 cycles (32ms) */
#define WINDOW_64CLK_gc  (0x04<<4) /* 64 cycles (64ms) */
#define WINDOW_128CLK_gc  (0x05<<4) /* 128 cycles (0.128s) */
#define WINDOW_256CLK_gc  (0x06<<4) /* 256 cycles (0.256s) */
#define WINDOW_512CLK_gc  (0x07<<4) /* 512 cycles (0.512s) */
#define WINDOW_1KCLK_gc  (0x08<<4) /* 1K cycles (1.0s) */
#define WINDOW_2KCLK_gc  (0x09<<4) /* 2K cycles (2.0s) */
#define WINDOW_4KCLK_gc  (0x0A<<4) /* 4K cycles (4.1s) */
#define WINDOW_8KCLK_gc  (0x0B<<4)  /* 8K cycles (8.2s) */
#define LB_RWLOCK_gc  (0x3A<<0) /* Read and write lock */
#define LB_NOLOCK_gc  (0xC5<<0)  /* No locks */
#define NVMCTRL_CMD_NONE_gc  (0x00<<0) /* No Command */
#define NVMCTRL_CMD_PAGEWRITE_gc  (0x01<<0) /* Write page */
#define NVMCTRL_CMD_PAGEERASE_gc  (0x02<<0) /* Erase page */
#define NVMCTRL_CMD_PAGEERASEWRITE_gc  (0x03<<0) /* Erase and write page */
#define NVMCTRL_CMD_PAGEBUFCLR_gc  (0x04<<0) /* Page buffer clear */
#define NVMCTRL_CMD_CHIPERASE_gc  (0x05<<0) /* Chip erase */
#define NVMCTRL_CMD_EEERASE_gc  (0x06<<0) /* EEPROM erase */
#define NVMCTRL_CMD_FUSEWRITE_gc  (0x07<<0)  /* Write fuse (PDI only) */
#define PORT_ISC_INTDISABLE_gc  (0x00<<0) /* Interrupt disabled but input buffer enabled */
#define PORT_ISC_BOTHEDGES_gc  (0x01<<0) /* Sense Both Edges */
#define PORT_ISC_RISING_gc  (0x02<<0) /* Sense Rising Edge */
#define PORT_ISC_FALLING_gc  (0x03<<0) /* Sense Falling Edge */
#define PORT_ISC_INPUT_DISABLE_gc  (0x04<<0) /* Digital Input Buffer disabled */
#define PORT_ISC_LEVEL_gc  (0x05<<0)  /* Sense low Level */
#define PORTMUX_EVOUTA_DEFAULT_gc  (0x00<<0) /* EVOUT on PA2 */
#define PORTMUX_EVOUTA_ALT1_gc  (0x01<<0)  /* EVOUT on PA7 */
#define PORTMUX_EVOUTB_DEFAULT_gc  (0x00<<1)  /* EVOUT on PB2 */
#define PORTMUX_EVOUTC_DEFAULT_gc  (0x00<<2)  /* EVOUT on PC2 */
#define PORTMUX_LUT0_DEFAULT_gc  (0x00<<0) /* Out: PA4 In: PA0, PA1, PA2 */
#define PORTMUX_LUT0_ALT1_gc  (0x01<<0)  /* Out: PB4 In: PA0, PA1, PA2 */
#define PORTMUX_LUT1_DEFAULT_gc  (0x00<<1) /* Out: PA7 In: PC3, PC4, PC5 */
#define PORTMUX_LUT1_ALT1_gc  (0x01<<1)  /* Out: PC1 In: PC3, PC4, PC5 */
#define PORTMUX_LUT2_DEFAULT_gc  (0x00<<2)  /* Out: PB3 In: PB0, PB1, PB2 */
#define PORTMUX_LUT3_ALT1_gc  (0x01<<3)  /* Out: PA5 In: PC0, PC1, PC2 */
#define PORTMUX_SPI0_DEFAULT_gc  (0x00<<0) /* PA0, PA1, PA2, PA3 */
#define PORTMUX_SPI0_ALT1_gc  (0x01<<0) /* PC2, PC1, PC0, PC3 */
#define PORTMUX_SPI0_NONE_gc  (0x03<<0)  /* Not connected to any pins */
#define PORTMUX_TCA00_DEFAULT_gc  (0x00<<0) /* WO0 on PB0 */
#define PORTMUX_TCA00_ALT1_gc  (0x01<<0)  /* WO0 on PB3 */
#define PORTMUX_TCA01_DEFAULT_gc  (0x00<<1) /* WO1 on PB1 */
#define PORTMUX_TCA01_ALT1_gc  (0x01<<1)  /* WO1 on PB4 */
#define PORTMUX_TCA02_DEFAULT_gc  (0x00<<2) /* WO2 on PB2 */
#define PORTMUX_TCA02_ALT1_gc  (0x01<<2)  /* WO2 on PB5 */
#define PORTMUX_TCA03_DEFAULT_gc  (0x00<<3) /* WO3 on PA3 */
#define PORTMUX_TCA03_ALT1_gc  (0x01<<3)  /* WO3 on PC3 */
#define PORTMUX_TCA04_DEFAULT_gc  (0x00<<4)  /* WO4 on PA4 */
#define PORTMUX_TCA05_DEFAULT_gc  (0x00<<5)  /* WO5 on PA5 */
#define PORTMUX_TCB0_DEFAULT_gc  (0x00<<0) /* WO on PA5 */
#define PORTMUX_TCB0_ALT1_gc  (0x01<<0)  /* WO on PC0 */
#define PORTMUX_TCB1_DEFAULT_gc  (0x00<<1)  /* WO on PA3 */
#define PORTMUX_USART0_DEFAULT_gc  (0x00<<0) /* USART0 on PB[3:0] */
#define PORTMUX_USART0_ALT1_gc  (0x01<<0) /* USART0 on PA[4:1] */
#define PORTMUX_USART0_NONE_gc  (0x03<<0)  /* Not connected to any pins */
#define PORTMUX_USART1_DEFAULT_gc  (0x00<<2) /* USART1 on PA[4:1] */
#define PORTMUX_USART1_ALT1_gc  (0x01<<2) /* USART1 on PC[3:0] */
#define PORTMUX_USART1_NONE_gc  (0x03<<2)  /* Not connected to any pins */
#define RTC_CLKSEL_INT32K_gc  (0x00<<0) /* Internal 32kHz OSC */
#define RTC_CLKSEL_INT1K_gc  (0x01<<0) /* Internal 1kHz OSC */
#define RTC_CLKSEL_TOSC32K_gc  (0x02<<0) /* 32KHz Crystal OSC */
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
#define SLPCTRL_SMODE_IDLE_gc  (0x00<<1) /* Idle mode */
#define SLPCTRL_SMODE_STDBY_gc  (0x01<<1) /* Standby Mode */
#define SLPCTRL_SMODE_PDOWN_gc  (0x02<<1)  /* Power-down Mode */
#define SPI_MODE_0_gc  (0x00<<0) /* SPI Mode 0 */
#define SPI_MODE_1_gc  (0x01<<0) /* SPI Mode 1 */
#define SPI_MODE_2_gc  (0x02<<0) /* SPI Mode 2 */
#define SPI_MODE_3_gc  (0x03<<0)  /* SPI Mode 3 */
#define SPI_PRESC_DIV4_gc  (0x00<<1) /* System Clock / 4 */
#define SPI_PRESC_DIV16_gc  (0x01<<1) /* System Clock / 16 */
#define SPI_PRESC_DIV64_gc  (0x02<<1) /* System Clock / 64 */
#define SPI_PRESC_DIV128_gc  (0x03<<1)  /* System Clock / 128 */
#define TCA_SINGLE_CLKSEL_DIV1_gc  (0x00<<1) /* System Clock */
#define TCA_SINGLE_CLKSEL_DIV2_gc  (0x01<<1) /* System Clock / 2 */
#define TCA_SINGLE_CLKSEL_DIV4_gc  (0x02<<1) /* System Clock / 4 */
#define TCA_SINGLE_CLKSEL_DIV8_gc  (0x03<<1) /* System Clock / 8 */
#define TCA_SINGLE_CLKSEL_DIV16_gc  (0x04<<1) /* System Clock / 16 */
#define TCA_SINGLE_CLKSEL_DIV64_gc  (0x05<<1) /* System Clock / 64 */
#define TCA_SINGLE_CLKSEL_DIV256_gc  (0x06<<1) /* System Clock / 256 */
#define TCA_SINGLE_CLKSEL_DIV1024_gc  (0x07<<1)  /* System Clock / 1024 */
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
#define TCA_SPLIT_CLKSEL_DIV1_gc  (0x00<<1) /* System Clock */
#define TCA_SPLIT_CLKSEL_DIV2_gc  (0x01<<1) /* System Clock / 2 */
#define TCA_SPLIT_CLKSEL_DIV4_gc  (0x02<<1) /* System Clock / 4 */
#define TCA_SPLIT_CLKSEL_DIV8_gc  (0x03<<1) /* System Clock / 8 */
#define TCA_SPLIT_CLKSEL_DIV16_gc  (0x04<<1) /* System Clock / 16 */
#define TCA_SPLIT_CLKSEL_DIV64_gc  (0x05<<1) /* System Clock / 64 */
#define TCA_SPLIT_CLKSEL_DIV256_gc  (0x06<<1) /* System Clock / 256 */
#define TCA_SPLIT_CLKSEL_DIV1024_gc  (0x07<<1)  /* System Clock / 1024 */
#define TCA_SPLIT_CMD_NONE_gc  (0x00<<2) /* No Command */
#define TCA_SPLIT_CMD_UPDATE_gc  (0x01<<2) /* Force Update */
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
#define TWI_ACKACT_ACK_gc  (0x00<<2) /* Send ACK */
#define TWI_ACKACT_NACK_gc  (0x01<<2)  /* Send NACK */
#define TWI_AP_STOP_gc  (0x00<<0) /* Stop condition generated APIF */
#define TWI_AP_ADR_gc  (0x01<<0)  /* Address detection generated APIF */
#define TWI_BUSSTATE_UNKNOWN_gc  (0x00<<0) /* Unknown Bus State */
#define TWI_BUSSTATE_IDLE_gc  (0x01<<0) /* Bus is Idle */
#define TWI_BUSSTATE_OWNER_gc  (0x02<<0) /* This Module Controls The Bus */
#define TWI_BUSSTATE_BUSY_gc  (0x03<<0)  /* The Bus is Busy */
#define TWI_MCMD_NOACT_gc  (0x00<<0) /* No Action */
#define TWI_MCMD_REPSTART_gc  (0x01<<0) /* Issue Repeated Start Condition */
#define TWI_MCMD_RECVTRANS_gc  (0x02<<0) /* Receive or Transmit Data, depending on DIR */
#define TWI_MCMD_STOP_gc  (0x03<<0)  /* Issue Stop Condition */
#define TWI_SCMD_NOACT_gc  (0x00<<0) /* No Action */
#define TWI_SCMD_COMPTRANS_gc  (0x02<<0) /* Used To Complete a Transaction */
#define TWI_SCMD_RESPONSE_gc  (0x03<<0)  /* Used in Response to Address/Data Interrupt */
#define TWI_SDAHOLD_OFF_gc  (0x00<<2) /* SDA hold time off */
#define TWI_SDAHOLD_50NS_gc  (0x01<<2) /* Typical 50ns hold time */
#define TWI_SDAHOLD_300NS_gc  (0x02<<2) /* Typical 300ns hold time */
#define TWI_SDAHOLD_500NS_gc  (0x03<<2)  /* Typical 500ns hold time */
#define TWI_SDASETUP_4CYC_gc  (0x00<<4) /* SDA setup time is 4 clock cycles */
#define TWI_SDASETUP_8CYC_gc  (0x01<<4)  /* SDA setup time is 8 clock cycles */
#define TWI_TIMEOUT_DISABLED_gc  (0x00<<2) /* Bus Timeout Disabled */
#define TWI_TIMEOUT_50US_gc  (0x01<<2) /* 50 Microseconds */
#define TWI_TIMEOUT_100US_gc  (0x02<<2) /* 100 Microseconds */
#define TWI_TIMEOUT_200US_gc  (0x03<<2)  /* 200 Microseconds */
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
#define VREF_AC0REFSEL_1V024_gc  (0x00<<0) /* Voltage reference at 1.024V */
#define VREF_AC0REFSEL_2V048_gc  (0x01<<0) /* Voltage reference at 2.048V */
#define VREF_AC0REFSEL_2V5_gc  (0x02<<0) /* Voltage reference at 2.5V */
#define VREF_AC0REFSEL_4V096_gc  (0x03<<0) /* Voltage reference at 4.096V */
#define VREF_AC0REFSEL_AVDD_gc  (0x07<<0)  /* voltage reference at supply */
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
