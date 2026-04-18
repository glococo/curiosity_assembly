; AVR-GCC _gc "group configuration" defines
# define __AVR_GC__ STRINGIFY(avr/_(io,__AVR_DEVICE_NAME__)_gc.S)
# include __AVR_GC__

#define IS_FAMILY_SD ( defined __AVR_AVR32SD20__ || defined __AVR_AVR32SD28__ || defined __AVR_AVR32SD32__ )

