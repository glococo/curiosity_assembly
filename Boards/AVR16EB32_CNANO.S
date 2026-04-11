; Core: avr16eb32
; Datasheet: DS40002522A
; Target: AVR16EB32 CURIOSITY NANO
; Target datasheet: DS50003605B
#include <avr/io.h>

; Core Config
#define CORE_CLOCK_OSCHF      20000
#define CORE_CLOCK_OSC32K     32768

; Board Config
#define BOARD_CLOCK_MAIN      CORE_CLOCK_OSCHF
#define BOARD_CLOCK_RTC       CORE_CLOCK_OSC32K
#define BOARD_LED_PIN         PIN5_bp
#define BOARD_LED_PORT        PORTF
#define BOARD_BUTTON_PIN      PIN6_bp
#define BOARD_BUTTON_PORT     PORTF

; USART Config
#define USART_CONFIGURED
#define USART                 USART0
#define USART_TX              PIN1_bp
#define USART_RX              PIN2_bp
#define USART_PORT            PORTC
#define USART_ADDR            USART0_RXDATAL
#define USART_BAUD_RATE       38400
#define USART_DOUBLE_SPEED    1
; TWI Config (default)
#define TWI_CONFIGURED
; SPI Config
#define SPI_CONFIGURED
#define SPI_PORT              PORTA
#define SPI_MOSI              PIN4_bp
#define SPI_MISO              PIN5_bp
#define SPI_SCK               PIN6_bp
#define SPI_SS                PIN7_bp

#include "../Hal/ALL.S"

FUNC HAL_BOARD_SETUP
    clr     __zero_reg__
    ; HAL SPEED AWARENESS
    ldi4    r22, BOARD_CLOCK_MAIN
    sts4    HAL_CLK_MAIN_KHZ, r22

    ldi     r22, 0
    rcall   HAL_CLKCTRL_PRESCALER
    rcall   HAL_USART_BAUDRATE_UPD

    #ifdef TWI_CONFIGURED                                 /* TWI CONFIG */
    _PORTMUX_ROUTEA( TWI, 0, DEFAULT )                    ; Ensure TWI0 is in PA2/PA3
    #endif

    #ifdef SPI_CONFIGURED                                 /* SPI CONFIG */
    ldi     r22, ( PIN4_bm | PIN6_bm | PIN7_bm )          ; MOSI, SCK, SS
    out     _(_(V,SPI_PORT),_DIR), r22
    _PIN_OUT_SET( SPI_PORT, SPI_SS )                      ; SS High
    ldi     r18, (PORT_PULLUPEN_bm | PORT_ISC_FALLING_gc) ; PORTF PIN0 as IRQ
    sts     PORTF_PIN0CTRL, r18
    #endif

    #ifdef USART_CONFIGURED                               /* USART CONFIG */
    _PORTMUX_ROUTEA( USART, 0, ALT4 )                     ; Ensure USART0 is in PC1/PC2/PC3)
    _PIN_DIR_SET( USART_PORT, USART_TX )                  ; Set USART_TX PIN as OUTPUT
    ldi     r18, USART_TXEN_bm | (USART_DOUBLE_SPEED<<1)  ; USART Enable
    sts     _(USART,_CTRLB), r18                          ;
    #endif

    ; PIN LED CONFIG
    _PIN_DIR_SET( BOARD_LED_PORT, BOARD_LED_PIN )         ; Set PIN as OUTPUT

    ; PIN BUTTON CONFIG
    ldi     r18, (PORT_PULLUPEN_bm | PORT_ISC_FALLING_gc) ; Config BOARD_BUTTON/SW0 Pin
    sts     _(BOARD_BUTTON_PORT, _PIN6CTRL), r18
ENDF HAL_BOARD_SETUP
