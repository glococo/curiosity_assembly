#define ADC_REFSEL_VDD_bm     0x00
#define ADC_REFSEL_VREFA_bm   0x02
#define ADC_REFSEL_1V024_bm   0x04
#define ADC_REFSEL_2V048_bm   0x05
#define ADC_REFSEL_4V096_bm   0x06
#define ADC_REFSEL_2V500_bm   0x07

#define ADC_PRESC_DIV2_bm      0x00
#define ADC_PRESC_DIV4_bm      0x01
#define ADC_PRESC_DIV6_bm      0x02
#define ADC_PRESC_DIV8_bm      0x03
#define ADC_PRESC_DIV10_bm     0x04
#define ADC_PRESC_DIV12_bm     0x05
#define ADC_PRESC_DIV14_bm     0x06
#define ADC_PRESC_DIV16_bm     0x07
#define ADC_PRESC_DIV20_bm     0x08
#define ADC_PRESC_DIV24_bm     0x09
#define ADC_PRESC_DIV28_bm     0x0A
#define ADC_PRESC_DIV32_bm     0x0B
#define ADC_PRESC_DIV40_bm     0x0C
#define ADC_PRESC_DIV48_bm     0x0D
#define ADC_PRESC_DIV56_bm     0x0E
#define ADC_PRESC_DIV64_bm     0x0F

#define ADC_SAMPNUM_NONE_bm       0x00
#define ADC_SAMPNUM_ACC2_bm       0x01
#define ADC_SAMPNUM_ACC4_bm       0x02
#define ADC_SAMPNUM_ACC8_bm       0x03
#define ADC_SAMPNUM_ACC16_bm      0x04
#define ADC_SAMPNUM_ACC32_bm      0x05
#define ADC_SAMPNUM_ACC64_bm      0x06
#define ADC_SAMPNUM_ACC128_bm     0x07
#define ADC_SAMPNUM_ACC256_bm     0x08
#define ADC_SAMPNUM_ACC512_bm     0x09
#define ADC_SAMPNUM_ACC1024_bm    0x0A

#define ADC_START_STOP_bm           0x00
#define ADC_START_IMMEDIATE_bm      0x01
#define ADC_START_MUXPOS_WRITE_bm   0x02
#define ADC_START_MUXNEG_WRITE_bm   0x03
#define ADC_START_EVENT_TRIGGER_bm  0x04

#define ADC_MODE_SINGLE_8bit_bm     0x00
#define ADC_MODE_SINGLE_12bit_bm    0x10
#define ADC_MODE_SERIES_bm          0x20
#define ADC_MODE_SERIES_SCALING_bm  0x30
#define ADC_MODE_BURST_bm           0x40
#define ADC_MODE_BURST_SCALING_bm   0x50

#define ADC_MUXPOS_AIN00_gc         0x00
#define ADC_MUXPOS_AIN01_gc         0x01
#define ADC_MUXPOS_AIN02_gc         0x02
#define ADC_MUXPOS_AIN03_gc         0x03
#define ADC_MUXPOS_AIN04_gc         0x04
#define ADC_MUXPOS_AIN05_gc         0x05
#define ADC_MUXPOS_AIN06_gc         0x06
#define ADC_MUXPOS_AIN07_gc         0x07
#define ADC_MUXPOS_AIN08_gc         0x08
#define ADC_MUXPOS_AIN09_gc         0x09
#define ADC_MUXPOS_AIN10_gc         0x0A
#define ADC_MUXPOS_AIN11_gc         0x0B
#define ADC_MUXPOS_AIN12_gc         0x0C
#define ADC_MUXPOS_AIN13_gc         0x0D
#define ADC_MUXPOS_AIN14_gc         0x0E
#define ADC_MUXPOS_AIN15_gc         0x0F
#define ADC_MUXPOS_AIN16_gc         0x10
#define ADC_MUXPOS_AIN17_gc         0x11
#define ADC_MUXPOS_AIN18_gc         0x12
#define ADC_MUXPOS_AIN19_gc         0x13
#define ADC_MUXPOS_AIN20_gc         0x14
#define ADC_MUXPOS_AIN21_gc         0x15
#define ADC_MUXPOS_AIN22_gc         0x16
#define ADC_MUXPOS_AIN23_gc         0x17
#define ADC_MUXPOS_AIN24_gc         0x18
#define ADC_MUXPOS_AIN25_gc         0x19
#define ADC_MUXPOS_AIN26_gc         0x1A
#define ADC_MUXPOS_AIN27_gc         0x1B
#define ADC_MUXPOS_AIN28_gc         0x1C
#define ADC_MUXPOS_AIN29_gc         0x1D
#define ADC_MUXPOS_AIN30_gc         0x1E
#define ADC_MUXPOS_AIN31_gc         0x1F
#define ADC_MUXPOS_GND_gc           0x30
#define ADC_MUXPOS_VDDDIV10_gc      0x31
#define ADC_MUXPOS_TEMPSENSE_gc     0x32
#define ADC_MUXPOS_DAC0_gc          0x38

.section .progmem.rodata
ADC_DIV_TABLE:
    .byte 2, 4, 6, 8, 10, 12, 14, 16, 20, 24, 28, 32, 40, 48, 56, 64
