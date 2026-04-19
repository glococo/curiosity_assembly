; -----------------------------------------------------------------------------
; File: Examples/19_TWI_Temperature_sensor/main.S
; Description: Reads temperature data from MCP9804 sensor via TWI.
;              - Initializes TWI and read MCP9804 DEV ID.
;              - Periodically reads Temperature register
;              - Prints raw to USART.
; -----------------------------------------------------------------------------
#include "../../Drivers/MCP9804/driver.S"

FUNC main
    rcall   HAL_BOARD_SETUP                         ; Basic board initialization
    _DEVBUFFER(TX_DEVBUFFER, 128, USART_ADDR)     ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __\r\n")
    _STR("__ MCP9804 Temperature Sensor Example __\r\n")$ _STR_FLUSH()

    rcall   HAL_TWI_INIT                            ; Initialize TWI

    MCP9804_READ_REG    MCP9804_REG_ID
    brcc    read_ok
    _STR("Error: Sensor read failed!\r\n")
    jmp     flush_end

  read_ok:
    _DEBUG_REG2( r22, "Device ID: ")
    MCP9804_READ_REG    MCP9804_REG_MANUFACTURER
    _DEBUG_REG2( r22, "Manufacturer ID: ")
    MCP9804_READ_REG    MCP9804_REG_CONF
    _DEBUG_REG2( r22, "Configuration: ")
    MCP9804_READ_REG    MCP9804_REG_RESOLUTION
    _DEBUG_REG2( r22, "Resolution: ")

  main_loop:
    rcall   MCP9804_READ_TEMPERATURE
    brcs    error_temp
    _STR("Temperature: ")$ _STR_U8(r22)$ _STR(".")$ _STR_U16(r24,4)$ _STR("º\n\r")$ _STR_FLUSH()

    _DELAY_MS(3000)
    rjmp    main_loop

  error_temp:
    _STR("Error: Read temp failed!\r\n")
  flush_end:
    _STR_FLUSH()
  loop:
    rjmp    loop

ENDF main
