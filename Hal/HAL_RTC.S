; RTC WIP HAL/API functions

DEFUN RTC_INIT_THREE_SECOND
  RTC_INIT_THREE_SECOND:
  PUSH_MANY r18, r19
    ; RTC CLOCK
    ; lds     r18, RTC_STATUS         ; Read status flag before update CTRLA
    ldi     r18, lo8( 384 )
    ldi     r19, hi8( 384 )
    sts     RTC_PERL, r18
    sts     RTC_PERH, r19

    ldi     r18, RTC_OVF_bm         ; RTC Overflow interrupt enable
    sts     RTC_INTCTRL, r18

    ; RTC run in Standby, Prescaler Clk/256 and Enable
    ldi     r18, RTC_RUNSTDBY_bm | RTC_PRESCALER_3_bm | RTC_RTCEN_bm
    sts     RTC_CTRLA, r18
  POP_MANY r19, r18
  ret
ENDF RTC_INIT_THREE_SECOND
