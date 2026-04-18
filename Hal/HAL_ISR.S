#define _ISR( vector, function )   HAL_ISR vector, function

.macro HAL_ISR_EXE name, function
  .warning "__ISR__ name: \name, function: \function"
  .pushsection .text.\name, "ax", @progbits
  .global \name
  .type \name, @function
  \name:
    push    r22             ; Push the work register (e.g., r22)
    in      r22, SREG
    push    r22             ; Push SREG
    rcall   \function
    pop     r22
    out     SREG, r22
    pop     r22
    reti
  .size \name, .-\name
  .popsection
.endm

; HAL_ISR vect, function
.macro HAL_ISR vect, function
  .ifc \vect,PORTA
    HAL_ISR_EXE PORTA_PORT_vect, \function
    .exitm
  .endif
  .ifc \vect,PORTB
    HAL_ISR_EXE PORTB_PORT_vect, \function
    .exitm
  .endif
  .ifc \vect,PORTC
    HAL_ISR_EXE PORTC_PORT_vect, \function
    .exitm
  .endif
  .ifc \vect,PORTD
    HAL_ISR_EXE PORTD_PORT_vect, \function
    .exitm
  .endif
  .ifc \vect,PORTE
    HAL_ISR_EXE PORTE_PORT_vect, \function
    .exitm
  .endif
  .ifc \vect,PORTF
    HAL_ISR_EXE PORTF_PORT_vect, \function
    .exitm
  .endif
  .ifc \vect,PORTG
    HAL_ISR_EXE PORTG_PORT_vect, \function
    .exitm
  .endif

  ;; Fallback: Define the ISR with the provided (or expanded) name
  HAL_ISR_EXE \vect, \function
.endm
