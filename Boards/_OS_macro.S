; Assembly macros

#define GLUE(a, b)          a##b
#define _(p, r)             GLUE(p, r)

.macro DEFUN name
  .section .text.\name, "ax", @progbits
  .global \name
  .type \name, @function
  .func \name
.endm

.macro ENDF name
  .endfunc
  .size \name, .-\name
.endm

.macro PUSH_MANY regs:vararg
  .irp reg, \regs
    push \reg
  .endr
.endm

.macro POP_MANY regs:vararg
  .irp reg, \regs
    pop \reg
  .endr
.endm

.macro ISR_START r
    push \r             ; Push the work register (e.g., r24)
    in   \r, SREG
    push \r             ; Push SREG
.endm

.macro ISR_END r
    pop  \r             ; Restore SREG into the work register
    out  SREG, \r
    pop  \r             ; Restore the work register
    reti
.endm

.macro OS_DELAY_MS milliseconds
  ldi   r18, lo8( \milliseconds )
  ldi   r19, hi8( \milliseconds )
  rcall OS_SOFT_DELAY_MS
.endm

.macro	mov4  r_dest, r_src
    wmov \r_dest,   \r_src
    wmov \r_dest+2, \r_src+2
.endm
