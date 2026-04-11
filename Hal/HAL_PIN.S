#define _PIN_DIR_SET(port,pin)   sbi _(_(V, port), _DIR), pin
#define _PIN_DIR_CLR(port,pin)   cbi _(_(V, port), _DIR), pin
#define _PIN_OUT_SET(port,pin)   sbi _(_(V, port), _OUT), pin
#define _PIN_OUT_CLR(port,pin)   cbi _(_(V, port), _OUT), pin

#define _PIN_FLG(port,pin)       sbi _(_(V, port), _INTFLAGS), pin
#define _PIN_TGL(port,pin)       sbi _(_(V, port), _IN), pin
