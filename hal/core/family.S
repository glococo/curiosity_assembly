; AVR-GCC _gc "group configuration" defines
# define __AVR_GC__ STRINGIFY(../def/_(io,__AVR_DEVICE_NAME__)_gc.S)
# include __AVR_GC__

#ifdef ERRCTRL_CTRLA
  #define IS_FAMILY_SD
#endif
