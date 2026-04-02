; -----------------------------------------------------------------------------
; File: Examples/18_I2C_UV_sensor/main.S
; Description: Reads raw UV light data from VEML6075 sensor via I2C.
;              - Initializes I2C and VEML6075.
;              - Periodically reads UVA, UVB, UVCOMP1 (Visible), and UVCOMP2 (IR).
;              - Prints raw counts to USART.
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
    ldi2    ZL, TX_DEVBUFFER                        ; Set Z to point to the device buffer for PRINT functions

    PRINT_STR "__ CURIOSITY ASSEMBLY __\r\n"
    PRINT_STR "__ VEML6075 UV Sensor Example __\r\n"
    rcall   HAL_USART_FLUSH_DEVICEBUFFER
    rcall   HAL_I2C_INIT                            ; Initialize I2C

    rcall   VEML6075_READ_ID
    tst     r18
    breq    sensor_enable
    PRINT_STR "Error: Device ID read failed!\r\n"
    rjmp    flush_end

  sensor_enable:
    DEBUG_STR_REG r22, "Device ID: "                ; r22 contains ID (Expected 0x26)
    rcall   VEML6075_ENABLE                         ; Configure Sensor (Power ON, 100ms integration time)
    tst     r18
    breq    start_loop
    PRINT_STR "Error: Configuration failed!\r\n"
    rjmp    flush_end

  start_loop:
    PRINT_STR "Start reading ...\r\n"
    rcall   HAL_USART_FLUSH_DEVICEBUFFER
    HAL_DELAY_MS 150                                ; Wait for first conversion (100ms IT + margin)

  main_loop:
    rcall   VEML6075_READ
    sbrc    r18, 0
    rjmp    read_error
    PRINT_STR "UVI: "
    lds2    r22, VEML6075_UVI
    rcall   HAL_PRINT_UINT16_REG
    PRINT_STR "  UVA comp: "
    lds2    r22, VEML6075_UVAc
    rcall   HAL_PRINT_UINT16_REG
    PRINT_STR "  UVB comp: "
    lds2    r22, VEML6075_UVBc
    rcall   HAL_PRINT_UINT16_REG
    rcall   HAL_PRINT_NEW_LINE
    PRINT_STR "  UVA raw: "
    lds2    r22, VEML6075_UVA
    rcall   HAL_PRINT_UINT16_REG
    PRINT_STR "  UVB raw: "
    lds2    r22, VEML6075_UVB
    rcall   HAL_PRINT_UINT16_REG
    PRINT_STR "  COMP1: "
    lds2    r22, VEML6075_UVCOMP1
    rcall   HAL_PRINT_UINT16_REG
    PRINT_STR "  COMP2: "
    lds2    r22, VEML6075_UVCOMP2
    rcall   HAL_PRINT_UINT16_REG
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER
    HAL_DELAY_MS  2000
    rjmp    main_loop

  read_error:
    PRINT_STR "Error: Sensor read failed!\r\n"
    rcall   HAL_PRINT_NEW_LINE
  flush_end:
    rcall   HAL_USART_FLUSH_DEVICEBUFFER
  loop:
    rjmp    loop

ENDF main
