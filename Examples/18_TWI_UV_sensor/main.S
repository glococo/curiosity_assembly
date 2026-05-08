; -----------------------------------------------------------------------------
; File: Examples/18_TWI_UV_sensor/main.S
; Description: Reads raw UV light data from VEML6075 sensor via TWI.
;              - Initializes TWI and VEML6075.
;              - Periodically reads UVA, UVB, UVCOMP1 (Visible), and UVCOMP2 (IR).
;              - Prints raw counts to USART.
; -----------------------------------------------------------------------------
#include "../../Drivers/VEML6075/driver.S"

FUNC main
    _BOARD_SETUP()                                  ; Basic board initialization
    _DEVBUFFER(DEVBUFFER, 128, USART_ADDR)          ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __\r\n")
    _STR("__ VEML6075 UV Sensor Example __\r\n")$ _STR_FLUSH()

    _TWI_MASTER()                                   ; Initialize TWI with default baudrate
    call    VEML6075_READ_ID
    brcc    read_ok
    _STR("Error: Device ID read failed!\r\n")
    jmp     end

  read_ok:
    call    VEML6075_ENABLE                         ; Configure Sensor (Power ON, 100ms integration time)
    brcc    read_device
    _STR("Error: Enable failed!\r\n")
    jmp     end

  read_device:
    _STR("Start reading ...\r\n")$ _STR_FLUSH()
    _DELAY_MS(150)                                  ; Wait for first conversion (100ms IT + margin)

  main_loop:
    call    VEML6075_READ
    brcc    print_results
    _STR("Error: Sensor read failed!\r\n")
    jmp     end

  print_results:
    lds2    r22, VEML6075_UVI
    _STR("UVI: ")$ _STR_U16()
    lds2    r22, VEML6075_UVAc
    _STR("  UVA comp: ")$ _STR_U16()
    lds2    r22, VEML6075_UVBc
    _STR("  UVB comp: ")$ _STR_U16()$ _STRNR()
    lds2    r22, VEML6075_UVA
    _STR("  UVA raw: ")$ _STR_U16()
    lds2    r22, VEML6075_UVB
    _STR("  UVB raw: ")$ _STR_U16()
    lds2    r22, VEML6075_UVCOMP1
    _STR("  COMP1: ")$ _STR_U16()
    lds2    r22, VEML6075_UVCOMP2
    _STR("  COMP2: ")$ _STR_U16()$ _STRNR()$ _STR_FLUSH()
    _DELAY_MS(2000)
    jmp     main_loop

  end:
    _STR_FLUSH()
  loop:
    jmp     loop

ENDF main
