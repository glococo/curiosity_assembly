; Core: avr__xx__
; Datasheet: DS________x
; Target: AVR__xx__ CURIOSITY NANO board
; Target datasheet: DS________x
#include <avr/io.h>

; Core Config
#define CORE_CLOCK_OSCHF      20000
#define CORE_CLOCK_OSC32K     32768

; Board Config
#define BOARD_CLOCK_MAIN      CORE_CLOCK_OSCHF
#define BOARD_CLOCK_RTC       CORE_CLOCK_OSC32K
#define BOARD_LED_PIN         PINx_bp
#define BOARD_LED_PORT        PORTx
#define BOARD_BUTTON_PIN      PINx_bp
#define BOARD_BUTTON_PORT     PORTx

; USART Config
#define USART_CONFIGURED
#define USART                 USARTx
#define USART_TX              PINx_bp
#define USART_RX              PINx_bp
#define USART_PORT            PORTx
#define USART_ADDR            USARTx_RXDATAL
#define USART_BAUD_RATE       38400
#define USART_DOUBLE_SPEED    1
; TWI Config (default)
#define TWI_CONFIGURED
; SPI Config
#define SPI_CONFIGURED
#define SPI_PORT              PORTx
#define SPI_MOSI              PINx_bp
#define SPI_MISO              PINx_bp
#define SPI_SCK               PINx_bp
#define SPI_SS                PINx_bp
#define SPI_IRQ_PIN           PINx_bp
#define SPI_IRQ_PORT          PORTx

#include "../Hal/ALL.S"

FUNC HAL_BOARD_SETUP
    _ZERO_FULL_INIT()
    ; MAKE SURE OSCHF default speed ___________________________
    ; OSCHF set Internal HighFreq Oscilator from 4mhz to 24MHZ
    ldi     r22, CLKCTRL_FRQSEL_24M_gc
    call   HAL_CLKCTRL_OSCHF_SET
    ; IF DEVICE > 32K FLASH, make sure 1st page is MAPPED _____
    ; NVMCTRL Unified Memory Map to first page in Devices>32KB flash
    ; (For lds access to .progmem.rodata text)
    sts     NVMCTRL_CTRLB, __zero_reg__
    ; _________________________________________________________

    ;_CLOCK_AWARENESS_INIT()                               ; HAL SPEED AWARENESS
    _CLOCK_HARDCODED_INIT()
    _USART_CONFIG()
    _SPI_CONFIG()
    _TWI_CONFIG()

    ; PIN LED CONFIG
    _PIN_DIR_SET(BOARD_LED_PORT, BOARD_LED_PIN)           ; Set PIN as OUTPUT

    ; PIN BUTTON CONFIG
    ldi     r22, (PORT_PULLUPEN_bm | PORT_ISC_FALLING_gc)
    sts     _PIN_CTRL( BOARD_BUTTON_PORT, BOARD_BUTTON_PIN ), r22  ; Config BOARD_BUTTON/SW0 Pin
ENDF HAL_BOARD_SETUP
