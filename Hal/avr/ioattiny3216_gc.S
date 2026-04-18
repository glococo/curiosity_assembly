#define AC_HYSMODE_OFF_gc  (0x00<<1) /* No hysteresis */
#define AC_HYSMODE_10mV_gc  (0x01<<1) /* 10mV hysteresis */
#define AC_HYSMODE_25mV_gc  (0x02<<1) /* 25mV hysteresis */
#define AC_HYSMODE_50mV_gc  (0x03<<1)  /* 50mV hysteresis */
#define AC_INTMODE_BOTHEDGE_gc  (0x00<<4) /* Any Edge */
#define AC_INTMODE_NEGEDGE_gc  (0x02<<4) /* Negative Edge */
#define AC_INTMODE_POSEDGE_gc  (0x03<<4)  /* Positive Edge */
#define AC_LPMODE_DIS_gc  (0x00<<3) /* Low power mode disabled */
#define AC_LPMODE_EN_gc  (0x01<<3)  /* Low power mode enabled */
#define AC_MUXNEG_PIN0_gc  (0x00<<0) /* Negative Pin 0 */
#define AC_MUXNEG_PIN1_gc  (0x01<<0) /* Negative Pin 1 */
#define AC_MUXNEG_VREF_gc  (0x02<<0) /* Voltage Reference */
#define AC_MUXNEG_DAC_gc  (0x03<<0)  /* DAC output */
#define AC_MUXPOS_PIN0_gc  (0x00<<3) /* Positive Pin 0 */
#define AC_MUXPOS_PIN1_gc  (0x01<<3) /* Positive Pin 1 */
#define AC_MUXPOS_PIN2_gc  (0x02<<3) /* Positive Pin 2 */
#define AC_MUXPOS_PIN3_gc  (0x03<<3)  /* Positive Pin 3 */
#define ADC_ASDV_ASVOFF_gc  (0x00<<4) /* The Automatic Sampling Delay Variation is disabled */
#define ADC_ASDV_ASVON_gc  (0x01<<4)  /* The Automatic Sampling Delay Variation is enabled */
#define ADC_DUTYCYC_DUTY50_gc  (0x00<<0) /* 50% Duty cycle */
#define ADC_DUTYCYC_DUTY25_gc  (0x01<<0)  /* 25% Duty cycle */
#define ADC_INITDLY_DLY0_gc  (0x00<<5) /* Delay 0 CLK_ADC cycles */
#define ADC_INITDLY_DLY16_gc  (0x01<<5) /* Delay 16 CLK_ADC cycles */
#define ADC_INITDLY_DLY32_gc  (0x02<<5) /* Delay 32 CLK_ADC cycles */
#define ADC_INITDLY_DLY64_gc  (0x03<<5) /* Delay 64 CLK_ADC cycles */
#define ADC_INITDLY_DLY128_gc  (0x04<<5) /* Delay 128 CLK_ADC cycles */
#define ADC_INITDLY_DLY256_gc  (0x05<<5)  /* Delay 256 CLK_ADC cycles */
#define ADC_MUXPOS_AIN0_gc  (0x00<<0) /* ADC input pin 0 */
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
#define ADC_MUXPOS_PTC_gc  (0x1B<<0) /* PTC/DAC2 */
#define ADC_MUXPOS_DAC0_gc  (0x1C<<0) /* DAC0/DAC0 */
#define ADC_MUXPOS_INTREF_gc  (0x1D<<0) /* Internal Ref */
#define ADC_MUXPOS_TEMPSENSE_gc  (0x1E<<0) /* Temp sensor/DAC1 */
#define ADC_MUXPOS_GND_gc  (0x1F<<0)  /* GND */
#define ADC_PRESC_DIV2_gc  (0x00<<0) /* CLK_PER divided by 2 */
#define ADC_PRESC_DIV4_gc  (0x01<<0) /* CLK_PER divided by 4 */
#define ADC_PRESC_DIV8_gc  (0x02<<0) /* CLK_PER divided by 8 */
#define ADC_PRESC_DIV16_gc  (0x03<<0) /* CLK_PER divided by 16 */
#define ADC_PRESC_DIV32_gc  (0x04<<0) /* CLK_PER divided by 32 */
#define ADC_PRESC_DIV64_gc  (0x05<<0) /* CLK_PER divided by 64 */
#define ADC_PRESC_DIV128_gc  (0x06<<0) /* CLK_PER divided by 128 */
#define ADC_PRESC_DIV256_gc  (0x07<<0)  /* CLK_PER divided by 256 */
#define ADC_REFSEL_INTREF_gc  (0x00<<4) /* Internal reference */
#define ADC_REFSEL_VDDREF_gc  (0x01<<4) /* VDD */
#define ADC_REFSEL_VREFA_gc  (0x02<<4)  /* External reference */
#define ADC_RESSEL_10BIT_gc  (0x00<<2) /* 10-bit mode */
#define ADC_RESSEL_8BIT_gc  (0x01<<2)  /* 8-bit mode */
#define ADC_SAMPNUM_ACC1_gc  (0x00<<0) /* 1 ADC sample */
#define ADC_SAMPNUM_ACC2_gc  (0x01<<0) /* Accumulate 2 samples */
#define ADC_SAMPNUM_ACC4_gc  (0x02<<0) /* Accumulate 4 samples */
#define ADC_SAMPNUM_ACC8_gc  (0x03<<0) /* Accumulate 8 samples */
#define ADC_SAMPNUM_ACC16_gc  (0x04<<0) /* Accumulate 16 samples */
#define ADC_SAMPNUM_ACC32_gc  (0x05<<0) /* Accumulate 32 samples */
#define ADC_SAMPNUM_ACC64_gc  (0x06<<0)  /* Accumulate 64 samples */
#define ADC_WINCM_NONE_gc  (0x00<<0) /* No Window Comparison */
#define ADC_WINCM_BELOW_gc  (0x01<<0) /* Below Window */
#define ADC_WINCM_ABOVE_gc  (0x02<<0) /* Above Window */
#define ADC_WINCM_INSIDE_gc  (0x03<<0) /* Inside Window */
#define ADC_WINCM_OUTSIDE_gc  (0x04<<0)  /* Outside Window */
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
#define CCL_CLKSRC_CLKPER_gc  (0x00<<6) /* CLK_PER is clocking the LUT */
#define CCL_CLKSRC_IN2_gc  (0x01<<6)  /* IN[2] is clocking the LUT */
#define CCL_EDGEDET_DIS_gc  (0x00<<7) /* Edge detector is disabled */
#define CCL_EDGEDET_EN_gc  (0x01<<7)  /* Edge detector is enabled */
#define CCL_FILTSEL_DISABLE_gc  (0x00<<4) /* Filter disabled */
#define CCL_FILTSEL_SYNCH_gc  (0x01<<4) /* Synchronizer enabled */
#define CCL_FILTSEL_FILTER_gc  (0x02<<4)  /* Filter enabled */
#define CCL_INSEL0_MASK_gc  (0x00<<0) /* Masked input */
#define CCL_INSEL0_FEEDBACK_gc  (0x01<<0) /* Feedback input source */
#define CCL_INSEL0_LINK_gc  (0x02<<0) /* Linked LUT input source */
#define CCL_INSEL0_EVENT0_gc  (0x03<<0) /* Event input source 0 */
#define CCL_INSEL0_EVENT1_gc  (0x04<<0) /* Event input source 1 */
#define CCL_INSEL0_IO_gc  (0x05<<0) /* IO pin LUTn-IN0 input source */
#define CCL_INSEL0_AC0_gc  (0x06<<0) /* AC0 OUT input source */
#define CCL_INSEL0_TCB0_gc  (0x07<<0) /* TCB0 WO input source */
#define CCL_INSEL0_TCA0_gc  (0x08<<0) /* TCA0 WO0 input source */
#define CCL_INSEL0_TCD0_gc  (0x09<<0) /* TCD0 WOA input source */
#define CCL_INSEL0_USART0_gc  (0x0A<<0) /* USART0 XCK input source */
#define CCL_INSEL0_SPI0_gc  (0x0B<<0) /* SPI0 SCK source */
#define CCL_INSEL0_AC1_gc  (0x0C<<0) /* AC1 OUT input source */
#define CCL_INSEL0_TCB1_gc  (0x0D<<0) /* TCB1 WO input source */
#define CCL_INSEL0_AC2_gc  (0x0E<<0)  /* AC2 OUT input source */
#define CCL_INSEL1_MASK_gc  (0x00<<4) /* Masked input */
#define CCL_INSEL1_FEEDBACK_gc  (0x01<<4) /* Feedback input source */
#define CCL_INSEL1_LINK_gc  (0x02<<4) /* Linked LUT input source */
#define CCL_INSEL1_EVENT0_gc  (0x03<<4) /* Event input source 0 */
#define CCL_INSEL1_EVENT1_gc  (0x04<<4) /* Event input source 1 */
#define CCL_INSEL1_IO_gc  (0x05<<4) /* IO pin LUTn-N1 input source */
#define CCL_INSEL1_AC0_gc  (0x06<<4) /* AC0 OUT input source */
#define CCL_INSEL1_TCB0_gc  (0x07<<4) /* TCB0 WO input source */
#define CCL_INSEL1_TCA0_gc  (0x08<<4) /* TCA0 WO1 input source */
#define CCL_INSEL1_TCD0_gc  (0x09<<4) /* TCD0 WOB input source */
#define CCL_INSEL1_USART0_gc  (0x0A<<4) /* USART0 TXD input source */
#define CCL_INSEL1_SPI0_gc  (0x0B<<4) /* SPI0 MOSI input source */
#define CCL_INSEL1_AC1_gc  (0x0C<<4) /* AC1 OUT input source */
#define CCL_INSEL1_TCB1_gc  (0x0D<<4) /* TCB1 WO input source */
#define CCL_INSEL1_AC2_gc  (0x0E<<4)  /* AC2 OUT input source */
#define CCL_INSEL2_MASK_gc  (0x00<<0) /* Masked input */
#define CCL_INSEL2_FEEDBACK_gc  (0x01<<0) /* Feedback input source */
#define CCL_INSEL2_LINK_gc  (0x02<<0) /* Linked LUT input source */
#define CCL_INSEL2_EVENT0_gc  (0x03<<0) /* Event input source 0 */
#define CCL_INSEL2_EVENT1_gc  (0x04<<0) /* Event input source 1 */
#define CCL_INSEL2_IO_gc  (0x05<<0) /* IO pin LUTn-IN2 input source */
#define CCL_INSEL2_AC0_gc  (0x06<<0) /* AC0 OUT input source */
#define CCL_INSEL2_TCB0_gc  (0x07<<0) /* TCB0 WO input source */
#define CCL_INSEL2_TCA0_gc  (0x08<<0) /* TCA0 WO2 input source */
#define CCL_INSEL2_TCD0_gc  (0x09<<0) /* TCD0 WOA input source */
#define CCL_INSEL2_SPI0_gc  (0x0B<<0) /* SPI0 MISO source */
#define CCL_INSEL2_AC1_gc  (0x0C<<0) /* AC1 OUT input source */
#define CCL_INSEL2_TCB1_gc  (0x0D<<0) /* TCB1 WO input source */
#define CCL_INSEL2_AC2_gc  (0x0E<<0)  /* AC2 OUT input source */
#define CCL_SEQSEL_DISABLE_gc  (0x00<<0) /* Sequential logic disabled */
#define CCL_SEQSEL_DFF_gc  (0x01<<0) /* D FlipFlop */
#define CCL_SEQSEL_JK_gc  (0x02<<0) /* JK FlipFlop */
#define CCL_SEQSEL_LATCH_gc  (0x03<<0) /* D Latch */
#define CCL_SEQSEL_RS_gc  (0x04<<0)  /* RS Latch */
#define CLKCTRL_CLKSEL_OSC20M_gc  (0x00<<0) /* 20MHz internal oscillator */
#define CLKCTRL_CLKSEL_OSCULP32K_gc  (0x01<<0) /* 32KHz internal Ultra Low Power oscillator */
#define CLKCTRL_CLKSEL_XOSC32K_gc  (0x02<<0) /* 32.768kHz external crystal oscillator */
#define CLKCTRL_CLKSEL_EXTCLK_gc  (0x03<<0)  /* External clock */
#define CLKCTRL_CSUT_1K_gc  (0x00<<4) /* 1K cycles */
#define CLKCTRL_CSUT_16K_gc  (0x01<<4) /* 16K cycles */
#define CLKCTRL_CSUT_32K_gc  (0x02<<4) /* 32K cycles */
#define CLKCTRL_CSUT_64K_gc  (0x03<<4)  /* 64K cycles */
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
#define EVSYS_ASYNCCH0_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_ASYNCCH0_CCL_LUT0_gc  (0x01<<0) /* Configurable Custom Logic LUT0 */
#define EVSYS_ASYNCCH0_CCL_LUT1_gc  (0x02<<0) /* Configurable Custom Logic LUT1 */
#define EVSYS_ASYNCCH0_AC0_OUT_gc  (0x03<<0) /* Analog Comparator 0 out */
#define EVSYS_ASYNCCH0_TCD0_CMPBCLR_gc  (0x04<<0) /* Timer/Counter D0 compare B clear */
#define EVSYS_ASYNCCH0_TCD0_CMPASET_gc  (0x05<<0) /* Timer/Counter D0 compare A set */
#define EVSYS_ASYNCCH0_TCD0_CMPBSET_gc  (0x06<<0) /* Timer/Counter D0 compare B set */
#define EVSYS_ASYNCCH0_TCD0_PROGEV_gc  (0x07<<0) /* Timer/Counter D0 program event */
#define EVSYS_ASYNCCH0_RTC_OVF_gc  (0x08<<0) /* Real Time Counter overflow */
#define EVSYS_ASYNCCH0_RTC_CMP_gc  (0x09<<0) /* Real Time Counter compare */
#define EVSYS_ASYNCCH0_PORTA_PIN0_gc  (0x0A<<0) /* Asynchronous Event from Pin PA0 */
#define EVSYS_ASYNCCH0_PORTA_PIN1_gc  (0x0B<<0) /* Asynchronous Event from Pin PA1 */
#define EVSYS_ASYNCCH0_PORTA_PIN2_gc  (0x0C<<0) /* Asynchronous Event from Pin PA2 */
#define EVSYS_ASYNCCH0_PORTA_PIN3_gc  (0x0D<<0) /* Asynchronous Event from Pin PA3 */
#define EVSYS_ASYNCCH0_PORTA_PIN4_gc  (0x0E<<0) /* Asynchronous Event from Pin PA4 */
#define EVSYS_ASYNCCH0_PORTA_PIN5_gc  (0x0F<<0) /* Asynchronous Event from Pin PA5 */
#define EVSYS_ASYNCCH0_PORTA_PIN6_gc  (0x10<<0) /* Asynchronous Event from Pin PA6 */
#define EVSYS_ASYNCCH0_PORTA_PIN7_gc  (0x11<<0) /* Asynchronous Event from Pin PA7 */
#define EVSYS_ASYNCCH0_UPDI_gc  (0x12<<0) /* Unified Program and debug interface */
#define EVSYS_ASYNCCH0_AC1_OUT_gc  (0x13<<0) /* Analog Comparator 1 out */
#define EVSYS_ASYNCCH0_AC2_OUT_gc  (0x14<<0)  /* Analog Comparator 2 out */
#define EVSYS_ASYNCCH1_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_ASYNCCH1_CCL_LUT0_gc  (0x01<<0) /* Configurable custom logic LUT0 */
#define EVSYS_ASYNCCH1_CCL_LUT1_gc  (0x02<<0) /* Configurable custom logic LUT1 */
#define EVSYS_ASYNCCH1_AC0_OUT_gc  (0x03<<0) /* Analog Comparator 0 out */
#define EVSYS_ASYNCCH1_TCD0_CMPBCLR_gc  (0x04<<0) /* Timer/Counter D0 compare B clear */
#define EVSYS_ASYNCCH1_TCD0_CMPASET_gc  (0x05<<0) /* Timer/Counter D0 compare A set */
#define EVSYS_ASYNCCH1_TCD0_CMPBSET_gc  (0x06<<0) /* Timer/Counter D0 compare B set */
#define EVSYS_ASYNCCH1_TCD0_PROGEV_gc  (0x07<<0) /* Timer/Counter D0 program event */
#define EVSYS_ASYNCCH1_RTC_OVF_gc  (0x08<<0) /* Real Time Counter overflow */
#define EVSYS_ASYNCCH1_RTC_CMP_gc  (0x09<<0) /* Real Time Counter compare */
#define EVSYS_ASYNCCH1_PORTB_PIN0_gc  (0x0A<<0) /* Asynchronous Event from Pin PB0 */
#define EVSYS_ASYNCCH1_PORTB_PIN1_gc  (0x0B<<0) /* Asynchronous Event from Pin PB1 */
#define EVSYS_ASYNCCH1_PORTB_PIN2_gc  (0x0C<<0) /* Asynchronous Event from Pin PB2 */
#define EVSYS_ASYNCCH1_PORTB_PIN3_gc  (0x0D<<0) /* Asynchronous Event from Pin PB3 */
#define EVSYS_ASYNCCH1_PORTB_PIN4_gc  (0x0E<<0) /* Asynchronous Event from Pin PB4 */
#define EVSYS_ASYNCCH1_PORTB_PIN5_gc  (0x0F<<0) /* Asynchronous Event from Pin PB5 */
#define EVSYS_ASYNCCH1_PORTB_PIN6_gc  (0x10<<0) /* Asynchronous Event from Pin PB6 */
#define EVSYS_ASYNCCH1_PORTB_PIN7_gc  (0x11<<0) /* Asynchronous Event from Pin PB7 */
#define EVSYS_ASYNCCH1_AC1_OUT_gc  (0x12<<0) /* Analog Comparator 1 out */
#define EVSYS_ASYNCCH1_AC2_OUT_gc  (0x13<<0)  /* Analog Comparator 2 out */
#define EVSYS_ASYNCCH2_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_ASYNCCH2_CCL_LUT0_gc  (0x01<<0) /* Configurable Custom Logic LUT0 */
#define EVSYS_ASYNCCH2_CCL_LUT1_gc  (0x02<<0) /* Configurable Custom Logic LUT1 */
#define EVSYS_ASYNCCH2_AC0_OUT_gc  (0x03<<0) /* Analog Comparator 0 out */
#define EVSYS_ASYNCCH2_TCD0_CMPBCLR_gc  (0x04<<0) /* Timer/Counter D0 compare B clear */
#define EVSYS_ASYNCCH2_TCD0_CMPASET_gc  (0x05<<0) /* Timer/Counter D0 compare A set */
#define EVSYS_ASYNCCH2_TCD0_CMPBSET_gc  (0x06<<0) /* Timer/Counter D0 compare B set */
#define EVSYS_ASYNCCH2_TCD0_PROGEV_gc  (0x07<<0) /* Timer/Counter D0 program event */
#define EVSYS_ASYNCCH2_RTC_OVF_gc  (0x08<<0) /* Real Time Counter overflow */
#define EVSYS_ASYNCCH2_RTC_CMP_gc  (0x09<<0) /* Real Time Counter compare */
#define EVSYS_ASYNCCH2_PORTC_PIN0_gc  (0x0A<<0) /* Asynchronous Event from Pin PC0 */
#define EVSYS_ASYNCCH2_PORTC_PIN1_gc  (0x0B<<0) /* Asynchronous Event from Pin PC1 */
#define EVSYS_ASYNCCH2_PORTC_PIN2_gc  (0x0C<<0) /* Asynchronous Event from Pin PC2 */
#define EVSYS_ASYNCCH2_PORTC_PIN3_gc  (0x0D<<0) /* Asynchronous Event from Pin PC3 */
#define EVSYS_ASYNCCH2_PORTC_PIN4_gc  (0x0E<<0) /* Asynchronous Event from Pin PC4 */
#define EVSYS_ASYNCCH2_PORTC_PIN5_gc  (0x0F<<0) /* Asynchronous Event from Pin PC5 */
#define EVSYS_ASYNCCH2_AC1_OUT_gc  (0x10<<0) /* Analog Comparator 1 out */
#define EVSYS_ASYNCCH2_AC2_OUT_gc  (0x11<<0)  /* Analog Comparator 2 out */
#define EVSYS_ASYNCCH3_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_ASYNCCH3_CCL_LUT0_gc  (0x01<<0) /* Configurable custom logic LUT0 */
#define EVSYS_ASYNCCH3_CCL_LUT1_gc  (0x02<<0) /* Configurable custom logic LUT1 */
#define EVSYS_ASYNCCH3_AC0_OUT_gc  (0x03<<0) /* Analog Comparator 0 out */
#define EVSYS_ASYNCCH3_TCD0_CMPBCLR_gc  (0x04<<0) /* Timer/Counter type D compare B clear */
#define EVSYS_ASYNCCH3_TCD0_CMPASET_gc  (0x05<<0) /* Timer/Counter type D compare A set */
#define EVSYS_ASYNCCH3_TCD0_CMPBSET_gc  (0x06<<0) /* Timer/Counter type D compare B set */
#define EVSYS_ASYNCCH3_TCD0_PROGEV_gc  (0x07<<0) /* Timer/Counter type D program event */
#define EVSYS_ASYNCCH3_RTC_OVF_gc  (0x08<<0) /* Real Time Counter overflow */
#define EVSYS_ASYNCCH3_RTC_CMP_gc  (0x09<<0) /* Real Time Counter compare */
#define EVSYS_ASYNCCH3_PIT_DIV8192_gc  (0x0A<<0) /* Periodic Interrupt CLK_RTC div 8192 */
#define EVSYS_ASYNCCH3_PIT_DIV4096_gc  (0x0B<<0) /* Periodic Interrupt CLK_RTC div 4096 */
#define EVSYS_ASYNCCH3_PIT_DIV2048_gc  (0x0C<<0) /* Periodic Interrupt CLK_RTC div 2048 */
#define EVSYS_ASYNCCH3_PIT_DIV1024_gc  (0x0D<<0) /* Periodic Interrupt CLK_RTC div 1024 */
#define EVSYS_ASYNCCH3_PIT_DIV512_gc  (0x0E<<0) /* Periodic Interrupt CLK_RTC div 512 */
#define EVSYS_ASYNCCH3_PIT_DIV256_gc  (0x0F<<0) /* Periodic Interrupt CLK_RTC div 256 */
#define EVSYS_ASYNCCH3_PIT_DIV128_gc  (0x10<<0) /* Periodic Interrupt CLK_RTC div 128 */
#define EVSYS_ASYNCCH3_PIT_DIV64_gc  (0x11<<0) /* Periodic Interrupt CLK_RTC div 64 */
#define EVSYS_ASYNCCH3_AC1_OUT_gc  (0x12<<0) /* Analog Comparator 1 out */
#define EVSYS_ASYNCCH3_AC2_OUT_gc  (0x13<<0)  /* Analog Comparator 2 out */
#define EVSYS_ASYNCUSER0_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_ASYNCUSER0_SYNCCH0_gc  (0x01<<0) /* Synchronous Event Channel 0 */
#define EVSYS_ASYNCUSER0_SYNCCH1_gc  (0x02<<0) /* Synchronous Event Channel 1 */
#define EVSYS_ASYNCUSER0_ASYNCCH0_gc  (0x03<<0) /* Asynchronous Event Channel 0 */
#define EVSYS_ASYNCUSER0_ASYNCCH1_gc  (0x04<<0) /* Asynchronous Event Channel 1 */
#define EVSYS_ASYNCUSER0_ASYNCCH2_gc  (0x05<<0) /* Asynchronous Event Channel 2 */
#define EVSYS_ASYNCUSER0_ASYNCCH3_gc  (0x06<<0)  /* Asynchronous Event Channel 3 */
#define EVSYS_ASYNCUSER1_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_ASYNCUSER1_SYNCCH0_gc  (0x01<<0) /* Synchronous Event Channel 0 */
#define EVSYS_ASYNCUSER1_SYNCCH1_gc  (0x02<<0) /* Synchronous Event Channel 1 */
#define EVSYS_ASYNCUSER1_ASYNCCH0_gc  (0x03<<0) /* Asynchronous Event Channel 0 */
#define EVSYS_ASYNCUSER1_ASYNCCH1_gc  (0x04<<0) /* Asynchronous Event Channel 1 */
#define EVSYS_ASYNCUSER1_ASYNCCH2_gc  (0x05<<0) /* Asynchronous Event Channel 2 */
#define EVSYS_ASYNCUSER1_ASYNCCH3_gc  (0x06<<0)  /* Asynchronous Event Channel 3 */
#define EVSYS_ASYNCUSER10_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_ASYNCUSER10_SYNCCH0_gc  (0x01<<0) /* Synchronous Event Channel 0 */
#define EVSYS_ASYNCUSER10_SYNCCH1_gc  (0x02<<0) /* Synchronous Event Channel 1 */
#define EVSYS_ASYNCUSER10_ASYNCCH0_gc  (0x03<<0) /* Asynchronous Event Channel 0 */
#define EVSYS_ASYNCUSER10_ASYNCCH1_gc  (0x04<<0) /* Asynchronous Event Channel 1 */
#define EVSYS_ASYNCUSER10_ASYNCCH2_gc  (0x05<<0) /* Asynchronous Event Channel 2 */
#define EVSYS_ASYNCUSER10_ASYNCCH3_gc  (0x06<<0)  /* Asynchronous Event Channel 3 */
#define EVSYS_ASYNCUSER11_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_ASYNCUSER11_SYNCCH0_gc  (0x01<<0) /* Synchronous Event Channel 0 */
#define EVSYS_ASYNCUSER11_SYNCCH1_gc  (0x02<<0) /* Synchronous Event Channel 1 */
#define EVSYS_ASYNCUSER11_ASYNCCH0_gc  (0x03<<0) /* Asynchronous Event Channel 0 */
#define EVSYS_ASYNCUSER11_ASYNCCH1_gc  (0x04<<0) /* Asynchronous Event Channel 1 */
#define EVSYS_ASYNCUSER11_ASYNCCH2_gc  (0x05<<0) /* Asynchronous Event Channel 2 */
#define EVSYS_ASYNCUSER11_ASYNCCH3_gc  (0x06<<0)  /* Asynchronous Event Channel 3 */
#define EVSYS_ASYNCUSER12_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_ASYNCUSER12_SYNCCH0_gc  (0x01<<0) /* Synchronous Event Channel 0 */
#define EVSYS_ASYNCUSER12_SYNCCH1_gc  (0x02<<0) /* Synchronous Event Channel 1 */
#define EVSYS_ASYNCUSER12_ASYNCCH0_gc  (0x03<<0) /* Asynchronous Event Channel 0 */
#define EVSYS_ASYNCUSER12_ASYNCCH1_gc  (0x04<<0) /* Asynchronous Event Channel 1 */
#define EVSYS_ASYNCUSER12_ASYNCCH2_gc  (0x05<<0) /* Asynchronous Event Channel 2 */
#define EVSYS_ASYNCUSER12_ASYNCCH3_gc  (0x06<<0)  /* Asynchronous Event Channel 3 */
#define EVSYS_ASYNCUSER2_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_ASYNCUSER2_SYNCCH0_gc  (0x01<<0) /* Synchronous Event Channel 0 */
#define EVSYS_ASYNCUSER2_SYNCCH1_gc  (0x02<<0) /* Synchronous Event Channel 1 */
#define EVSYS_ASYNCUSER2_ASYNCCH0_gc  (0x03<<0) /* Asynchronous Event Channel 0 */
#define EVSYS_ASYNCUSER2_ASYNCCH1_gc  (0x04<<0) /* Asynchronous Event Channel 1 */
#define EVSYS_ASYNCUSER2_ASYNCCH2_gc  (0x05<<0) /* Asynchronous Event Channel 2 */
#define EVSYS_ASYNCUSER2_ASYNCCH3_gc  (0x06<<0)  /* Asynchronous Event Channel 3 */
#define EVSYS_ASYNCUSER3_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_ASYNCUSER3_SYNCCH0_gc  (0x01<<0) /* Synchronous Event Channel 0 */
#define EVSYS_ASYNCUSER3_SYNCCH1_gc  (0x02<<0) /* Synchronous Event Channel 1 */
#define EVSYS_ASYNCUSER3_ASYNCCH0_gc  (0x03<<0) /* Asynchronous Event Channel 0 */
#define EVSYS_ASYNCUSER3_ASYNCCH1_gc  (0x04<<0) /* Asynchronous Event Channel 1 */
#define EVSYS_ASYNCUSER3_ASYNCCH2_gc  (0x05<<0) /* Asynchronous Event Channel 2 */
#define EVSYS_ASYNCUSER3_ASYNCCH3_gc  (0x06<<0)  /* Asynchronous Event Channel 3 */
#define EVSYS_ASYNCUSER4_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_ASYNCUSER4_SYNCCH0_gc  (0x01<<0) /* Synchronous Event Channel 0 */
#define EVSYS_ASYNCUSER4_SYNCCH1_gc  (0x02<<0) /* Synchronous Event Channel 1 */
#define EVSYS_ASYNCUSER4_ASYNCCH0_gc  (0x03<<0) /* Asynchronous Event Channel 0 */
#define EVSYS_ASYNCUSER4_ASYNCCH1_gc  (0x04<<0) /* Asynchronous Event Channel 1 */
#define EVSYS_ASYNCUSER4_ASYNCCH2_gc  (0x05<<0) /* Asynchronous Event Channel 2 */
#define EVSYS_ASYNCUSER4_ASYNCCH3_gc  (0x06<<0)  /* Asynchronous Event Channel 3 */
#define EVSYS_ASYNCUSER5_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_ASYNCUSER5_SYNCCH0_gc  (0x01<<0) /* Synchronous Event Channel 0 */
#define EVSYS_ASYNCUSER5_SYNCCH1_gc  (0x02<<0) /* Synchronous Event Channel 1 */
#define EVSYS_ASYNCUSER5_ASYNCCH0_gc  (0x03<<0) /* Asynchronous Event Channel 0 */
#define EVSYS_ASYNCUSER5_ASYNCCH1_gc  (0x04<<0) /* Asynchronous Event Channel 1 */
#define EVSYS_ASYNCUSER5_ASYNCCH2_gc  (0x05<<0) /* Asynchronous Event Channel 2 */
#define EVSYS_ASYNCUSER5_ASYNCCH3_gc  (0x06<<0)  /* Asynchronous Event Channel 3 */
#define EVSYS_ASYNCUSER6_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_ASYNCUSER6_SYNCCH0_gc  (0x01<<0) /* Synchronous Event Channel 0 */
#define EVSYS_ASYNCUSER6_SYNCCH1_gc  (0x02<<0) /* Synchronous Event Channel 1 */
#define EVSYS_ASYNCUSER6_ASYNCCH0_gc  (0x03<<0) /* Asynchronous Event Channel 0 */
#define EVSYS_ASYNCUSER6_ASYNCCH1_gc  (0x04<<0) /* Asynchronous Event Channel 1 */
#define EVSYS_ASYNCUSER6_ASYNCCH2_gc  (0x05<<0) /* Asynchronous Event Channel 2 */
#define EVSYS_ASYNCUSER6_ASYNCCH3_gc  (0x06<<0)  /* Asynchronous Event Channel 3 */
#define EVSYS_ASYNCUSER7_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_ASYNCUSER7_SYNCCH0_gc  (0x01<<0) /* Synchronous Event Channel 0 */
#define EVSYS_ASYNCUSER7_SYNCCH1_gc  (0x02<<0) /* Synchronous Event Channel 1 */
#define EVSYS_ASYNCUSER7_ASYNCCH0_gc  (0x03<<0) /* Asynchronous Event Channel 0 */
#define EVSYS_ASYNCUSER7_ASYNCCH1_gc  (0x04<<0) /* Asynchronous Event Channel 1 */
#define EVSYS_ASYNCUSER7_ASYNCCH2_gc  (0x05<<0) /* Asynchronous Event Channel 2 */
#define EVSYS_ASYNCUSER7_ASYNCCH3_gc  (0x06<<0)  /* Asynchronous Event Channel 3 */
#define EVSYS_ASYNCUSER8_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_ASYNCUSER8_SYNCCH0_gc  (0x01<<0) /* Synchronous Event Channel 0 */
#define EVSYS_ASYNCUSER8_SYNCCH1_gc  (0x02<<0) /* Synchronous Event Channel 1 */
#define EVSYS_ASYNCUSER8_ASYNCCH0_gc  (0x03<<0) /* Asynchronous Event Channel 0 */
#define EVSYS_ASYNCUSER8_ASYNCCH1_gc  (0x04<<0) /* Asynchronous Event Channel 1 */
#define EVSYS_ASYNCUSER8_ASYNCCH2_gc  (0x05<<0) /* Asynchronous Event Channel 2 */
#define EVSYS_ASYNCUSER8_ASYNCCH3_gc  (0x06<<0)  /* Asynchronous Event Channel 3 */
#define EVSYS_ASYNCUSER9_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_ASYNCUSER9_SYNCCH0_gc  (0x01<<0) /* Synchronous Event Channel 0 */
#define EVSYS_ASYNCUSER9_SYNCCH1_gc  (0x02<<0) /* Synchronous Event Channel 1 */
#define EVSYS_ASYNCUSER9_ASYNCCH0_gc  (0x03<<0) /* Asynchronous Event Channel 0 */
#define EVSYS_ASYNCUSER9_ASYNCCH1_gc  (0x04<<0) /* Asynchronous Event Channel 1 */
#define EVSYS_ASYNCUSER9_ASYNCCH2_gc  (0x05<<0) /* Asynchronous Event Channel 2 */
#define EVSYS_ASYNCUSER9_ASYNCCH3_gc  (0x06<<0)  /* Asynchronous Event Channel 3 */
#define EVSYS_SYNCCH0_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_SYNCCH0_TCB0_gc  (0x01<<0) /* Timer/Counter B0 */
#define EVSYS_SYNCCH0_TCA0_OVF_LUNF_gc  (0x02<<0) /* Timer/Counter A0 overflow */
#define EVSYS_SYNCCH0_TCA0_HUNF_gc  (0x03<<0) /* Timer/Counter A0 underflow high byte (split mode) */
#define EVSYS_SYNCCH0_TCA0_CMP0_gc  (0x04<<0) /* Timer/Counter A0 compare 0 */
#define EVSYS_SYNCCH0_TCA0_CMP1_gc  (0x05<<0) /* Timer/Counter A0 compare 1 */
#define EVSYS_SYNCCH0_TCA0_CMP2_gc  (0x06<<0) /* Timer/Counter A0 compare 2 */
#define EVSYS_SYNCCH0_PORTC_PIN0_gc  (0x07<<0) /* Synchronous Event from Pin PC0 */
#define EVSYS_SYNCCH0_PORTC_PIN1_gc  (0x08<<0) /* Synchronous Event from Pin PC1 */
#define EVSYS_SYNCCH0_PORTC_PIN2_gc  (0x09<<0) /* Synchronous Event from Pin PC2 */
#define EVSYS_SYNCCH0_PORTC_PIN3_gc  (0x0A<<0) /* Synchronous Event from Pin PC3 */
#define EVSYS_SYNCCH0_PORTC_PIN4_gc  (0x0B<<0) /* Synchronous Event from Pin PC4 */
#define EVSYS_SYNCCH0_PORTC_PIN5_gc  (0x0C<<0) /* Synchronous Event from Pin PC5 */
#define EVSYS_SYNCCH0_PORTA_PIN0_gc  (0x0D<<0) /* Synchronous Event from Pin PA0 */
#define EVSYS_SYNCCH0_PORTA_PIN1_gc  (0x0E<<0) /* Synchronous Event from Pin PA1 */
#define EVSYS_SYNCCH0_PORTA_PIN2_gc  (0x0F<<0) /* Synchronous Event from Pin PA2 */
#define EVSYS_SYNCCH0_PORTA_PIN3_gc  (0x10<<0) /* Synchronous Event from Pin PA3 */
#define EVSYS_SYNCCH0_PORTA_PIN4_gc  (0x11<<0) /* Synchronous Event from Pin PA4 */
#define EVSYS_SYNCCH0_PORTA_PIN5_gc  (0x12<<0) /* Synchronous Event from Pin PA5 */
#define EVSYS_SYNCCH0_PORTA_PIN6_gc  (0x13<<0) /* Synchronous Event from Pin PA6 */
#define EVSYS_SYNCCH0_PORTA_PIN7_gc  (0x14<<0) /* Synchronous Event from Pin PA7 */
#define EVSYS_SYNCCH0_TCB1_gc  (0x15<<0)  /* Timer/Counter B1 */
#define EVSYS_SYNCCH1_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_SYNCCH1_TCB0_gc  (0x01<<0) /* Timer/Counter B0 */
#define EVSYS_SYNCCH1_TCA0_OVF_LUNF_gc  (0x02<<0) /* Timer/Counter A0 overflow */
#define EVSYS_SYNCCH1_TCA0_HUNF_gc  (0x03<<0) /* Timer/Counter A0 underflow high byte (split mode) */
#define EVSYS_SYNCCH1_TCA0_CMP0_gc  (0x04<<0) /* Timer/Counter A0 compare 0 */
#define EVSYS_SYNCCH1_TCA0_CMP1_gc  (0x05<<0) /* Timer/Counter A0 compare 1 */
#define EVSYS_SYNCCH1_TCA0_CMP2_gc  (0x06<<0) /* Timer/Counter A0 compare 2 */
#define EVSYS_SYNCCH1_PORTB_PIN0_gc  (0x08<<0) /* Synchronous Event from Pin PB0 */
#define EVSYS_SYNCCH1_PORTB_PIN1_gc  (0x09<<0) /* Synchronous Event from Pin PB1 */
#define EVSYS_SYNCCH1_PORTB_PIN2_gc  (0x0A<<0) /* Synchronous Event from Pin PB2 */
#define EVSYS_SYNCCH1_PORTB_PIN3_gc  (0x0B<<0) /* Synchronous Event from Pin PB3 */
#define EVSYS_SYNCCH1_PORTB_PIN4_gc  (0x0C<<0) /* Synchronous Event from Pin PB4 */
#define EVSYS_SYNCCH1_PORTB_PIN5_gc  (0x0D<<0) /* Synchronous Event from Pin PB5 */
#define EVSYS_SYNCCH1_PORTB_PIN6_gc  (0x0E<<0) /* Synchronous Event from Pin PB6 */
#define EVSYS_SYNCCH1_PORTB_PIN7_gc  (0x0F<<0) /* Synchronous Event from Pin PB7 */
#define EVSYS_SYNCCH1_TCB1_gc  (0x10<<0)  /* Timer/Counter B1 */
#define EVSYS_SYNCUSER0_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_SYNCUSER0_SYNCCH0_gc  (0x01<<0) /* Synchronous Event Channel 0 */
#define EVSYS_SYNCUSER0_SYNCCH1_gc  (0x02<<0)  /* Synchronous Event Channel 1 */
#define EVSYS_SYNCUSER1_OFF_gc  (0x00<<0) /* Off */
#define EVSYS_SYNCUSER1_SYNCCH0_gc  (0x01<<0) /* Synchronous Event Channel 0 */
#define EVSYS_SYNCUSER1_SYNCCH1_gc  (0x02<<0)  /* Synchronous Event Channel 1 */
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
#define RSTPINCFG_RST_gc  (0x02<<2)  /* Reset mode */
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
#define PORTMUX_LUT0_DEFAULT_gc  (0x00<<4) /* Default pin */
#define PORTMUX_LUT0_ALTERNATE_gc  (0x01<<4)  /* Alternate pin */
#define PORTMUX_LUT1_DEFAULT_gc  (0x00<<5) /* Default pin */
#define PORTMUX_LUT1_ALTERNATE_gc  (0x01<<5)  /* Alternate pin */
#define PORTMUX_SPI0_DEFAULT_gc  (0x00<<2) /* Default pins */
#define PORTMUX_SPI0_ALTERNATE_gc  (0x01<<2)  /* Alternate pins */
#define PORTMUX_TCA00_DEFAULT_gc  (0x00<<0) /* Default pin */
#define PORTMUX_TCA00_ALTERNATE_gc  (0x01<<0)  /* Alternate pin */
#define PORTMUX_TCA01_DEFAULT_gc  (0x00<<1) /* Default pin */
#define PORTMUX_TCA01_ALTERNATE_gc  (0x01<<1)  /* Alternate pin */
#define PORTMUX_TCA02_DEFAULT_gc  (0x00<<2) /* Default pin */
#define PORTMUX_TCA02_ALTERNATE_gc  (0x01<<2)  /* Alternate pin */
#define PORTMUX_TCA03_DEFAULT_gc  (0x00<<3) /* Default pin */
#define PORTMUX_TCA03_ALTERNATE_gc  (0x01<<3)  /* Alternate pin */
#define PORTMUX_TCA04_DEFAULT_gc  (0x00<<4) /* Default pin */
#define PORTMUX_TCA04_ALTERNATE_gc  (0x01<<4)  /* Alternate pin */
#define PORTMUX_TCA05_DEFAULT_gc  (0x00<<5) /* Default pin */
#define PORTMUX_TCA05_ALTERNATE_gc  (0x01<<5)  /* Alternate pin */
#define PORTMUX_TCB0_DEFAULT_gc  (0x00<<0) /* Default pin */
#define PORTMUX_TCB0_ALTERNATE_gc  (0x01<<0)  /* Alternate pin */
#define PORTMUX_TCB1_DEFAULT_gc  (0x00<<1) /* Default pin */
#define PORTMUX_TCB1_ALTERNATE_gc  (0x01<<1)  /* Alternate pin */
#define PORTMUX_TWI0_DEFAULT_gc  (0x00<<4) /* Default pins */
#define PORTMUX_TWI0_ALTERNATE_gc  (0x01<<4)  /* Alternate pins */
#define PORTMUX_USART0_DEFAULT_gc  (0x00<<0) /* Default pins */
#define PORTMUX_USART0_ALTERNATE_gc  (0x01<<0)  /* Alternate pins */
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
#define TCA_SINGLE_EVACT_POSEDGE_gc  (0x00<<1) /* Count on positive edge event */
#define TCA_SINGLE_EVACT_ANYEDGE_gc  (0x01<<1) /* Count on any edge event */
#define TCA_SINGLE_EVACT_HIGHLVL_gc  (0x02<<1) /* Count on prescaled clock while event line is 1. */
#define TCA_SINGLE_EVACT_UPDOWN_gc  (0x03<<1)  /* Count on prescaled clock. Event controls count direction. Up-count when event line is 0, down-count when event line is 1. */
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
#define TCB_CLKSEL_CLKDIV1_gc  (0x00<<1) /* CLK_PER (No Prescaling) */
#define TCB_CLKSEL_CLKDIV2_gc  (0x01<<1) /* CLK_PER/2 (From Prescaler) */
#define TCB_CLKSEL_CLKTCA_gc  (0x02<<1)  /* Use Clock from TCA */
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
#define TCD_CLKSEL_20MHZ_gc  (0x00<<5) /* 20 MHz oscillator */
#define TCD_CLKSEL_EXTCLK_gc  (0x02<<5) /* External clock */
#define TCD_CLKSEL_SYSCLK_gc  (0x03<<5)  /* System clock */
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
#define USART_RS485_OFF_gc  (0x00<<0) /* RS485 Mode disabled */
#define USART_RS485_EXT_gc  (0x01<<0) /* RS485 Mode External drive */
#define USART_RS485_INT_gc  (0x02<<0)  /* RS485 Mode Internal drive */
#define USART_RXMODE_NORMAL_gc  (0x00<<1) /* Normal mode */
#define USART_RXMODE_CLK2X_gc  (0x01<<1) /* CLK2x mode */
#define USART_RXMODE_GENAUTO_gc  (0x02<<1) /* Generic autobaud mode */
#define USART_RXMODE_LINAUTO_gc  (0x03<<1)  /* LIN constrained autobaud mode */
#define USART_SBMODE_1BIT_gc  (0x00<<3) /* 1 stop bit */
#define USART_SBMODE_2BIT_gc  (0x01<<3)  /* 2 stop bits */
#define VREF_ADC0REFSEL_0V55_gc  (0x00<<4) /* Voltage reference at 0.55V */
#define VREF_ADC0REFSEL_1V1_gc  (0x01<<4) /* Voltage reference at 1.1V */
#define VREF_ADC0REFSEL_2V5_gc  (0x02<<4) /* Voltage reference at 2.5V */
#define VREF_ADC0REFSEL_4V34_gc  (0x03<<4) /* Voltage reference at 4.34V */
#define VREF_ADC0REFSEL_1V5_gc  (0x04<<4)  /* Voltage reference at 1.5V */
#define VREF_ADC1REFSEL_0V55_gc  (0x00<<4) /* Voltage reference at 0.55V */
#define VREF_ADC1REFSEL_1V1_gc  (0x01<<4) /* Voltage reference at 1.1V */
#define VREF_ADC1REFSEL_2V5_gc  (0x02<<4) /* Voltage reference at 2.5V */
#define VREF_ADC1REFSEL_4V34_gc  (0x03<<4) /* Voltage reference at 4.34V */
#define VREF_ADC1REFSEL_1V5_gc  (0x04<<4)  /* Voltage reference at 1.5V */
#define VREF_DAC0REFSEL_0V55_gc  (0x00<<0) /* Voltage reference at 0.55V */
#define VREF_DAC0REFSEL_1V1_gc  (0x01<<0) /* Voltage reference at 1.1V */
#define VREF_DAC0REFSEL_2V5_gc  (0x02<<0) /* Voltage reference at 2.5V */
#define VREF_DAC0REFSEL_4V34_gc  (0x03<<0) /* Voltage reference at 4.34V */
#define VREF_DAC0REFSEL_1V5_gc  (0x04<<0)  /* Voltage reference at 1.5V */
#define VREF_DAC1REFSEL_0V55_gc  (0x00<<0) /* Voltage reference at 0.55V */
#define VREF_DAC1REFSEL_1V1_gc  (0x01<<0) /* Voltage reference at 1.1V */
#define VREF_DAC1REFSEL_2V5_gc  (0x02<<0) /* Voltage reference at 2.5V */
#define VREF_DAC1REFSEL_4V34_gc  (0x03<<0) /* Voltage reference at 4.34V */
#define VREF_DAC1REFSEL_1V5_gc  (0x04<<0)  /* Voltage reference at 1.5V */
#define VREF_DAC2REFSEL_0V55_gc  (0x00<<0) /* Voltage reference at 0.55V */
#define VREF_DAC2REFSEL_1V1_gc  (0x01<<0) /* Voltage reference at 1.1V */
#define VREF_DAC2REFSEL_2V5_gc  (0x02<<0) /* Voltage reference at 2.5V */
#define VREF_DAC2REFSEL_4V34_gc  (0x03<<0) /* Voltage reference at 4.34V */
#define VREF_DAC2REFSEL_1V5_gc  (0x04<<0)  /* Voltage reference at 1.5V */
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
