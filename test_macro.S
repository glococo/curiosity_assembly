#define GLUE(a, b)        a##b
#define _(p, r)           GLUE(p, r)

#define VPORTC_DIR  0x0008
#define USART_PORT  PORTC

#define _PORT_DIR(port, pin) sbi _(_(V, port), _DIR), pin

_PORT_DIR(USART_PORT, 1)
