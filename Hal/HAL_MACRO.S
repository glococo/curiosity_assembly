#define r0                0
#define r1                1
#define r2                2
#define r3                3
#define r4                4
#define r5                5
#define r6                6
#define r7                7
#define r8                8
#define r9                9
#define r10               10
#define r11               11
#define r12               12
#define r13               13
#define r14               14
#define r15               15
#define r16               16
#define r17               17
#define r18               18
#define r19               19
#define r20               20
#define r21               21
#define r22               22
#define r23               23
#define r24               24
#define r25               25
#define r26               26
#define r27               27
#define r28               28
#define r29               29
#define r30               30
#define r31               31

#define r(n)              (n)
#define __zero_reg__      r2

#define GLUE(a, b)        a##b
#define _(p, r)           GLUE(p, r)

#define DEF_TO_STR(x)     #x
#define STRINGIFY(x)      DEF_TO_STR(x)
#define DEFUN             FUNC          // DEFUN to be purged. (old function definition)
.macro FUNC name
  .section .text.\name, "ax", @progbits
  .global \name
  .type \name, @function
  .func \name
  \name:
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

.macro CLR_MANY regs:vararg
  .irp reg, \regs
    clr \reg
  .endr
.endm

.macro CLR_BLOCK start, count
    .set _i, 0
    .rept \count
        clr \start + _i
        .set _i, _i + 1
    .endr
.endm

.macro MOVW_BLOCK dest, src, count
    .set _i, 0
    .rept \count
        movw \dest + 2*_i, \src + 2*_i
        .set _i, _i + 1
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
