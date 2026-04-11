/* ___ LAN9252 System Registers (Direct SPI/HBI access) ___ */

#define LAN9252_ECAT_PRAM_RD_DATA        0x000   // EtherCAT Process RAM Read Data FIFO (32 bytes)
#define LAN9252_ECAT_PRAM_WR_DATA        0x020   // EtherCAT Process RAM Write Data FIFO (32 bytes)
#define LAN9252_ID_REV                   0x050   // Chip ID and Revision
#define LAN9252_IRQ_CFG                  0x054   // Interrupt Configuration
#define LAN9252_INT_STS                  0x058   // Interrupt Status
#define LAN9252_INT_EN                   0x05C   // Interrupt Enable
#define LAN9252_BYTE_TEST                0x064   // Byte Order Test Register (0x87654321)
#define LAN9252_HW_CFG                   0x074   // Hardware Configuration
#define LAN9252_PMT_CTRL                 0x084   // Power Management Control
#define LAN9252_GPT_CFG                  0x08C   // General Purpose Timer Configuration
#define LAN9252_GPT_CNT                  0x090   // General Purpose Timer Count
#define LAN9252_FREE_RUN                 0x09C   // Free Running 25 MHz Counter
#define LAN9252_RESET_CTL                0x1F8   // Reset Control Register

/* Interrupt Configuration Register (IRQ_CFG) Bits */
#define IRQ_CFG_INT_DEAS_MASK            0xFF000000
#define IRQ_CFG_INT_DEAS_CLR             0x00004000
#define IRQ_CFG_INT_DEAS_STS             0x00002000
#define IRQ_CFG_IRQ_INT                  0x00001000
#define IRQ_CFG_IRQ_EN                   0x00000100
#define IRQ_CFG_IRQ_POL                  0x00000010
#define IRQ_CFG_IRQ_TYPE                 0x00000001

/* Interrupt Status Register (INT_STS) Bits */
#define INT_STS_SW_INT                   0x80000000
#define INT_STS_READY                    0x40000000
#define INT_STS_PHY_INT_B                0x08000000
#define INT_STS_PHY_INT_A                0x04000000
#define INT_STS_GPT_INT                  0x00080000
#define INT_STS_PME_INT                  0x00020000
#define INT_STS_ECAT_INT                 0x00000001

/* Interrupt Enable Register (INT_EN) Bits */
#define INT_EN_SW_INT_EN                 0x80000000
#define INT_EN_READY_EN                  0x40000000
#define INT_EN_PHY_INT_B_EN              0x08000000
#define INT_EN_PHY_INT_A_EN              0x04000000
#define INT_EN_GPT_INT_EN                0x00080000
#define INT_EN_PME_INT_EN                0x00020000
#define INT_EN_ECAT_INT_EN               0x00000001

/* Hardware Configuration Register (HW_CFG) Bits */
#define HW_CFG_READY                     0x08000000

/* Power Management Control Register (PMT_CTRL) Bits */
#define PMT_CTRL_PM_MODE_MASK            0xE0000000
#define PMT_CTRL_PM_SLEEP_EN             0x10000000
#define PMT_CTRL_PM_WAKE                 0x08000000
#define PMT_CTRL_LED_DIS                 0x04000000
#define PMT_CTRL_ECAT_DIS                0x00200000
#define PMT_CTRL_READY                   0x00000001

/* Reset Control Register (RESET_CTL) Bits */
#define RESET_CTL_ECAT_RST               0x00000040
#define RESET_CTL_PHY_B_RST              0x00000004
#define RESET_CTL_PHY_A_RST              0x00000002
#define RESET_CTL_DIGITAL_RST            0x00000001

/* EtherCAT CSR and PRAM Access Registers (bridge to EtherCAT core) */
#define LAN9252_ECAT_CSR_DATA            0x300   // EtherCAT CSR Data Register (32-bit)
#define LAN9252_ECAT_CSR_CMD             0x304   // EtherCAT CSR Command Register
#define LAN9252_ECAT_PRAM_RD_ADDR_LEN    0x308   // Process RAM Read Address & Length
#define LAN9252_ECAT_PRAM_RD_CMD         0x30C   // Process RAM Read Command
#define LAN9252_ECAT_PRAM_WR_ADDR_LEN    0x310   // Process RAM Write Address & Length
#define LAN9252_ECAT_PRAM_WR_CMD         0x314   // Process RAM Write Command

/* ECAT_CSR_CMD Bits */
#define ECAT_CSR_CMD_BUSY                0x80000000
#define ECAT_CSR_CMD_READ                0x40000000
#define ECAT_CSR_CMD_WRITE               0x00000000
#define ECAT_CSR_CMD_SIZE_1              0x00010000
#define ECAT_CSR_CMD_SIZE_2              0x00020000
#define ECAT_CSR_CMD_SIZE_4              0x00040000

/* ECAT_PRAM_RD_CMD Bits */
#define ECAT_PRAM_RD_CMD_BUSY            0x80000000
#define ECAT_PRAM_RD_CMD_ABORT           0x40000000

/* ECAT_PRAM_WR_CMD Bits */
#define ECAT_PRAM_WR_CMD_BUSY            0x80000000
#define ECAT_PRAM_WR_CMD_ABORT           0x40000000

/* SPI Instruction Codes */
#define LAN9252_SPI_READ                 0x03
#define LAN9252_SPI_WRITE                0x02
#define LAN9252_SPI_FASTREAD             0x0B

/* EtherCAT Core CSR Register Offsets (Indirectly Addressable) */
#define ESC_TYPE                         0x0000     /* General Information */
#define ESC_REVISION                     0x0001
#define ESC_BUILD                        0x0002     /* 16-bit */
#define ESC_FMMU_COUNT                   0x0004
#define ESC_SM_COUNT                     0x0005
#define ESC_RAM_SIZE                     0x0006
#define ESC_PORT_DESCRIPTOR              0x0007
#define ESC_FEATURES                     0x0008     /* 16-bit */
#define ESC_CONFIGURED_STATION_ADDR      0x0010     /* 16-bit */
#define ESC_CONFIGURED_STATION_ALIAS     0x0012     /* 16-bit */
#define ESC_WRITE_REG_ENABLE             0x0020
#define ESC_WRITE_REG_PROTECTION         0x0021
#define ESC_AL_CONTROL_WRITE_REG_ENABLE  0x0030
#define ESC_AL_CONTROL_WRITE_REG_PROT    0x0031
#define ESC_RESET_ECAT                   0x0040
#define ESC_RESET_PDI                    0x0041
#define ESC_DL_CONTROL                   0x0100     /* 32-bit */
#define ESC_DL_STATUS                    0x0110     /* 16-bit */
#define ESC_AL_CONTROL                   0x0120     /* 16-bit */
#define ESC_AL_STATUS                    0x0130     /* 16-bit */
#define ESC_AL_STATUS_CODE               0x0134     /* 16-bit */
#define ESC_RUN_LED_OVERRIDE             0x0138
#define ESC_PDI_CONTROL                  0x0140
#define ESC_ESC_CONFIG                   0x0141
#define ESC_ASIC_CONFIG                  0x0142     /* 16-bit */
#define ESC_PDI_CONFIG                   0x0150     /* 16-bit */
#define ESC_AL_EVENT_MASK                0x0200     /* 16-bit */
#define ESC_AL_EVENT_REQUEST             0x0220     /* 32-bit */
#define ESC_WDOG_DIVIDER                 0x0400     /* 16-bit */
#define ESC_WDOG_TIME_PDI                0x0410     /* 16-bit */
#define ESC_WDOG_TIME_PDATA              0x0420     /* 16-bit */
#define ESC_WDOG_STATUS                  0x0440     /* 16-bit */
#define ESC_WDOG_CNT_PDATA               0x0442
#define ESC_WDOG_CNT_PDI                 0x0443
#define ESC_EEPROM_CONTROL               0x0500     /* 16-bit */
#define ESC_EEPROM_ADDRESS               0x0504     /* 32-bit */
#define ESC_EEPROM_DATA                  0x0508     /* 32-bit */
#define ESC_MII_MGMT_CONTROL             0x0510     /* 16-bit */
#define ESC_PHY_ADDRESS                  0x0512
#define ESC_PHY_REG_ADDRESS              0x0513
#define ESC_PHY_DATA                     0x0514     /* 16-bit */
#define ESC_FMMU0_BASE                   0x0600
#define ESC_FMMU1_BASE                   0x0610
#define ESC_FMMU2_BASE                   0x0620
#define ESC_SM0_BASE                     0x0800
#define ESC_SM1_BASE                     0x0808
#define ESC_SM2_BASE                     0x0810
#define ESC_SM3_BASE                     0x0818
#define ESC_DC_SYSTEM_TIME               0x0910     /* 64-bit */
#define ESC_DC_SYSTEM_TIME_OFFSET        0x0918     /* 64-bit */
#define ESC_DC_SYSTEM_TIME_DELAY         0x0928     /* 32-bit */
#define ESC_DC_SPEED_COUNTER_START       0x0930     /* 16-bit */
#define ESC_DC_SPEED_COUNTER_DIFF        0x0932     /* 16-bit */
#define ESC_DC_SYNC0_CYCLE_TIME          0x09A0     /* 32-bit */
#define ESC_DC_SYNC1_CYCLE_TIME          0x09A4     /* 32-bit */

/* ESC_AL_CONTROL / ESC_AL_STATUS Bits */
#define AL_STATE_INIT                    0x01
#define AL_STATE_PREOP                   0x02
#define AL_STATE_BOOT                    0x03
#define AL_STATE_SAFEOP                  0x04
#define AL_STATE_OP                      0x08
#define AL_STATE_ERROR                   0x10

/* SyncManager Register Offsets (relative to SMx_BASE) */
#define SM_OFFS_PHYS_ADDR                0x00       /* 16-bit */
#define SM_OFFS_LENGTH                   0x02       /* 16-bit */
#define SM_OFFS_CONTROL                  0x04
#define SM_OFFS_STATUS                   0x05
#define SM_OFFS_ACTIVATE                 0x06
#define SM_OFFS_PDI_CONTROL              0x07

/* FMMU Register Offsets (relative to FMMUx_BASE) */
#define FMMU_OFFS_LOG_ADDR               0x00       /* 32-bit */
#define FMMU_OFFS_LENGTH                 0x04       /* 16-bit */
#define FMMU_OFFS_LOG_START_BIT          0x06
#define FMMU_OFFS_LOG_STOP_BIT           0x07
#define FMMU_OFFS_PHYS_ADDR              0x08       /* 16-bit */
#define FMMU_OFFS_PHYS_START_BIT         0x0A
#define FMMU_OFFS_TYPE                   0x0B
#define FMMU_OFFS_ACTIVATE               0x0C

/* PHY Register Indices (for use with ESC_PHY_REG_ADDRESS) */
#define PHY_INDEX_BASIC_CONTROL          0
#define PHY_INDEX_BASIC_STATUS           1
#define PHY_INDEX_ID_MSB                 2
#define PHY_INDEX_ID_LSB                 3
#define PHY_INDEX_AUTO_NEG_ADVERT        4
#define PHY_INDEX_AUTO_NEG_LP_ABILITY    5
#define PHY_INDEX_AUTO_NEG_EXPANSION     6
#define PHY_INDEX_SPECIAL_CONTROL_STATUS 31
