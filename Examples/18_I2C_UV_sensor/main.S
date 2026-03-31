; -----------------------------------------------------------------------------
; File: Examples/18_I2C_UV_sensor/main.S
; Description: Reads raw UV light data from VEML6075 sensor via I2C.
;              - Initializes I2C and VEML6075.
;              - Periodically reads UVA, UVB, UVCOMP1 (Visible), and UVCOMP2 (IR).
;              - Prints raw counts to USART.
;
; VEML6075 I2C Address: 0x10
; -----------------------------------------------------------------------------
#include "../../Drivers/VEML6075/driver.S"

; -----------------------------------------------------------------------------
; Function: main
; Description: Main application entry point.
; -----------------------------------------------------------------------------
; Define a 256-byte Dev-Ring-Buffer for USART (regular speed)
HAL_DEVICEBUFFER_DEFINE  TX_DEVBUFFER, 256, USART_ADDR

FUNC main
    rcall   HAL_BOARD_SETUP                         ; Basic board initialization
    HAL_DEVICEBUFFER_INIT TX_DEVBUFFER              ; Initialize USART TX buffer
    ldiw    ZL, TX_DEVBUFFER                        ; Set Z to point to the device buffer for PRINT functions

    PRINT_STR "\r\n__ VEML6075 UV Sensor Example __\r\n"
    rcall   HAL_USART_FLUSH_DEVICEBUFFER
    rcall   HAL_I2C_INIT                            ; Initialize I2C

    ldi     r22, VEML6075_REG_ID                    ; 1. Check Device ID
    rcall   VEML6075_READ_REG
    tst     r18
    brne    id_error
    DEBUG_STR_REG r22, "Device ID LSB: "            ; r23:r22 contains ID (Expected 0x0026)
    DEBUG_STR_REG r23, "Device ID MSB: "
    rjmp    setup_sensor

  id_error:
    PRINT_STR "Error: Device ID read failed!\r\n"
    rjmp    dead_end

  setup_sensor:
    ; 2. Configure Sensor (Power ON, 100ms integration time)
    ldi     r22, VEML6075_REG_CONF
    ldi     r24, (VEML6075_CONF_IT_100MS | VEML6075_CONF_HD_NORMAL | VEML6075_CONF_POWER_ON)
    ldi     r25, 0x00
    rcall   VEML6075_WRITE_REG
    tst     r18
    breq    start_loop
    PRINT_STR "Error: Configuration failed!\r\n"
    rjmp    dead_end

  start_loop:
    HAL_DELAY_MS 150                                ; Wait for first conversion (100ms IT + margin)

  main_loop:
    ldi     r22, VEML6075_REG_UVA                   ; Read UVA
    rcall   VEML6075_READ_REG
    tst     r18
    brne    read_error
    PRINT_STR "UVA: "
    rcall   HAL_PRINT_UINT16_REG

    ldi     r22, VEML6075_REG_UVB                   ; Read UVB
    rcall   VEML6075_READ_REG
    PRINT_STR "  UVB: "
    rcall   HAL_PRINT_UINT16_REG

    ldi     r22, VEML6075_REG_UVCOMP1               ; Read UVCOMP1 (Visible)
    rcall   VEML6075_READ_REG
    PRINT_STR "  COMP1: "
    rcall   HAL_PRINT_UINT16_REG

    ldi     r22, VEML6075_REG_UVCOMP2               ; Read UVCOMP2 (IR)
    rcall   VEML6075_READ_REG
    PRINT_STR "  COMP2: "
    rcall   HAL_PRINT_UINT16_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER
    HAL_DELAY_MS  2000
    rjmp    main_loop

  read_error:
    PRINT_STR "Error: Sensor read failed!\r\n"
    rcall   HAL_PRINT_NEW_LINE
  dead_end:
    rcall   HAL_USART_FLUSH_DEVICEBUFFER
  loop:
    rjmp    loop

ENDF main
