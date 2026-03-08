DEFUN HAL_USART_Print_Text_from_flash
  HAL_USART_Print_Text_from_flash:
  PUSH_MANY  r18, r19
  1:
    lpm   r18, Z+
    tst   r18
    breq  3f                  ; exit
  2:
    lds   r19, _(USART,_STATUS)
    sbrs  r19, USART_DREIF_bp
    rjmp  2b                  ; wait_for_DREIF
    sts   _(USART,_TXDATAL), r18
    rjmp  1b                  ; read next char
  3:
  POP_MANY   r19, r18
  ret
ENDF HAL_USART_Print_Text_from_flash

DEFUN HAL_UART_Print_Text_from_flash
  HAL_UART_Print_Text_from_flash:
  PUSH_MANY  r18, r19
  1:
    lpm   r18, Z+
    tst   r18
    breq  3f                  ; exit
  2:
    lds   r19, _(USART,_STATUS)
    sbrs  r19, USART_DREIF_bp
    rjmp  2b                  ; wait_for_DREIF
    sts   _(USART,_TXDATAL), r18
    rjmp  1b                  ; read next char
  3:
  POP_MANY   r19, r18
  ret
ENDF HAL_UART_Print_Text_from_flash

DEFUN HAL_UART_Print_char
  HAL_UART_Print_char:
  push  r19
  1:                          ; wait_for_DREIF
    lds   r19, _(USART,_STATUS)
    sbrs  r19, USART_DREIF_bp
    rjmp  1b
    sts   _(USART,_TXDATAL), r18
  pop   r19
  ret
ENDF HAL_UART_Print_char
