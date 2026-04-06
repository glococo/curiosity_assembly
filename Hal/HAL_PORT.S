#define _PORT_DIR(port,pin)   sbi _(_(V, port), _DIR), pin
#define _PORT_TGL(port,pin)   sbi _(_(V, port), _IN), pin
#define _PORT_OUT(port,pin)   sbi _(_(V, port), _OUT), pin
#define _PORT_FLG(port,pin)   sbi _(_(V, port), _INTFLAGS), pin
