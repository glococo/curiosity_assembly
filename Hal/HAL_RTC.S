; File: Hal/HAL_RTC.S
; Description: Real-Time Counter (RTC) helper library for AVR-Dx/Ex families.
;              Provides safe register writes with synchronization guards.
;

; -----------------------------------------------------------------------------
; Compile-time tick calculation macros
; -----------------------------------------------------------------------------
#define HAL_RTC_MS_TO_TICKS(ms, div)  (BOARD_CLOCK_RTC * ms / 1000 / div)
#define HAL_RTC_SEC_TO_TICKS(s, div)  HAL_RTC_MS_TO_TICKS((s) * 1000, div)

; Macro: HAL_RTC_INIT_STATIC
; Description: Statically initializes RTC with fixed ticks and prescaler.
.macro HAL_RTC_INIT_STATIC ticks, prescaler_bm
    .if (\ticks) > 65535
      .error "HAL_RTC_INIT_STATIC: PER overflows 16-bit register for clock: \ticks"
    .endif
    ldi     r22, lo8( \ticks )          ; Load ticks low byte
    ldi     r23, hi8( \ticks )          ; Load ticks high byte
    ldi     r18, RTC_RUNSTDBY_bm | (\prescaler_bm) | RTC_RTCEN_bm
    ldi     r19, RTC_OVF_bm             ; Enable Overflow interrupt
    rcall   HAL_RTC_CONFIG
.endm

; Macro: HAL_RTC_INIT_MS
; Description: Initializes RTC based on millisecond duration.
.macro HAL_RTC_INIT_MS ms, prescaler_div, prescaler_bm
    HAL_RTC_INIT_STATIC HAL_RTC_MS_TO_TICKS(\ms, \prescaler_div), \prescaler_bm
.endm

; Macro: HAL_RTC_PIT_ENABLE
; Description: Enables the Periodic Interrupt Timer (PIT).
.macro HAL_RTC_PIT_ENABLE period_bm
    ldi     r18, \period_bm | RTC_PITEN_bm
    ldi     r19, RTC_PI_bm              ; Enable Periodic Interrupt
    rcall   HAL_RTC_PIT_CONFIG
.endm

; Macro: HAL_RTC_PIT_DISABLE
; Description: Disables the Periodic Interrupt Timer.
.macro HAL_RTC_PIT_DISABLE
    rcall   HAL_RTC_PIT_OFF
.endm

; -----------------------------------------------------------------------------
; Synchronized Register Access Functions
; -----------------------------------------------------------------------------

; Function: HAL_RTC_WRITE_CTRLA
; Description: Safely writes to the RTC.CTRLA register with sync check.
; Inputs:  r18 - New CTRLA value
; Outputs: None
FUNC HAL_RTC_WRITE_CTRLA
  PUSH  r20
  0:  lds   r20, RTC_STATUS             ; Read status
      sbrc  r20, RTC_CTRLBUSY_bp        ; Check if CTRLA is busy
      rjmp  0b                          ; Wait for sync window
      sts   RTC_CTRLA, r18              ; Write new value
  1:  lds   r20, RTC_STATUS             ; Wait for write to complete
      sbrc  r20, RTC_CTRLBUSY_bp
      rjmp  1b
  POP  r20
ENDF HAL_RTC_WRITE_CTRLA

; Function: HAL_RTC_SET_PERIOD
; Description: Sets the RTC Period (PER) register.
; Inputs:  r23:r22 - 16-bit Period value
; Outputs: None
FUNC HAL_RTC_SET_PERIOD
  PUSH  r20
  0:  lds   r20, RTC_STATUS             ; Check PER sync status
      sbrc  r20, RTC_PERBUSY_bp
      rjmp  0b                          ; Wait if busy
      sts   RTC_PERL, r22               ; Write Period Low
      sts   RTC_PERH, r23               ; Write Period High
  POP  r20
ENDF HAL_RTC_SET_PERIOD

; Function: HAL_RTC_SET_COUNT
; Description: Sets the RTC Count (CNT) register.
; Inputs:  r23:r22 - 16-bit Count value
; Outputs: None
FUNC HAL_RTC_SET_COUNT
  PUSH  r20
  0:  lds   r20, RTC_STATUS             ; Check CNT sync status
      sbrc  r20, RTC_CNTBUSY_bp
      rjmp  0b                          ; Wait if busy
      sts   RTC_CNTL, r22               ; Write Count Low
      sts   RTC_CNTH, r23               ; Write Count High
  POP  r20
ENDF HAL_RTC_SET_COUNT

; Function: HAL_RTC_GET_COUNT
; Description: Reads the current 16-bit RTC Count value.
; Inputs:  None
; Outputs: r23:r22 - 16-bit Count value
FUNC HAL_RTC_GET_COUNT
  PUSH  r20
  0:  lds   r20, RTC_STATUS             ; Check CNT sync status
      sbrc  r20, RTC_CNTBUSY_bp
      rjmp  0b                          ; Wait if busy
      lds   r22, RTC_CNTL               ; Read Count Low
      lds   r23, RTC_CNTH               ; Read Count High
  POP  r20
ENDF HAL_RTC_GET_COUNT

; Function: HAL_RTC_SET_COMPARE
; Description: Sets the RTC Compare (CMP) register.
; Inputs:  r23:r22 - 16-bit Compare value
; Outputs: None
FUNC HAL_RTC_SET_COMPARE
  PUSH  r20
  0:  lds   r20, RTC_STATUS             ; Check CMP sync status
      sbrc  r20, RTC_CMPBUSY_bp
      rjmp  0b                          ; Wait if busy
      sts   RTC_CMPL, r22               ; Write Compare Low
      sts   RTC_CMPH, r23               ; Write Compare High
  POP  r20
ENDF HAL_RTC_SET_COMPARE

; -----------------------------------------------------------------------------
; Configuration Functions
; -----------------------------------------------------------------------------

; Function: HAL_RTC_CONFIG
; Description: Comprehensive RTC configuration (PER, INT, CTRLA).
; Inputs:  r23:r22 - Period value (ticks)
;          r19     - INTCTRL mask
;          r18     - CTRLA configuration bits
; Outputs: None
FUNC HAL_RTC_CONFIG
  PUSH_MANY r20, r21
    push    r18                         ; Save requested CTRLA bits

    ; Disable RTC before reconfiguring
      lds   r21, RTC_CTRLA              ; Read current CTRLA
      andi  r21, ~RTC_RTCEN_bm          ; Clear enable bit
      mov   r18, r21
      rcall HAL_RTC_WRITE_CTRLA         ; Apply disable

    ; Program PER and reset CNT
      rcall HAL_RTC_SET_PERIOD          ; Set Period
      clr   r22                         ; Reset Count to 0
      clr   r23
      rcall HAL_RTC_SET_COUNT

    ; Configure Interrupts and clear Flags
      sts   RTC_INTCTRL, r19            ; Set Interrupt Control
      ldi   r20, RTC_OVF_bm | RTC_CMP_bm
      sts   RTC_INTFLAGS, r20           ; Clear main RTC flags
      ldi   r20, RTC_PI_bm
      sts   RTC_PITINTFLAGS, r20        ; Clear PIT flags

    ; Re-enable with requested settings
      pop   r18                         ; Restore CTRLA bits
      rcall HAL_RTC_WRITE_CTRLA         ; Apply new config and Enable
  POP_MANY r21, r20
ENDF HAL_RTC_CONFIG

; Function: HAL_RTC_STOP
; Description: Disables the main RTC counter.
; Inputs:  None
; Outputs: None
FUNC HAL_RTC_STOP
  PUSH  r19
  0:  lds   r19, RTC_STATUS
      sbrc  r19, RTC_CTRLBUSY_bp
      rjmp  0b
      lds   r19, RTC_CTRLA              ; Read current CTRLA
      andi  r19, ~RTC_RTCEN_bm          ; Clear enable bit
      mov   r18, r19
      rcall HAL_RTC_WRITE_CTRLA         ; Write back
  POP  r19
ENDF HAL_RTC_STOP

; Function: HAL_RTC_START
; Description: Enables the main RTC counter.
; Inputs:  None
; Outputs: None
FUNC HAL_RTC_START
  PUSH  r19
  0:  lds   r19, RTC_STATUS
      sbrc  r19, RTC_CTRLBUSY_bp
      rjmp  0b
      lds   r19, RTC_CTRLA              ; Read current CTRLA
      ori   r19, RTC_RTCEN_bm           ; Set enable bit
      mov   r18, r19
      rcall HAL_RTC_WRITE_CTRLA         ; Write back
  POP  r19
ENDF HAL_RTC_START

; Function: HAL_RTC_PIT_CONFIG
; Description: Configures the Periodic Interrupt Timer (PIT).
; Inputs:  r18 - PITCTRLA value (Period | PITEN)
;          r19 - PITINTCTRL value (INT mask)
; Outputs: None
FUNC HAL_RTC_PIT_CONFIG
  PUSH  r20
      sts   RTC_PITINTCTRL, r19         ; Set PIT Interrupt Control
      ldi   r20, RTC_PI_bm
      sts   RTC_PITINTFLAGS, r20        ; Clear PIT flags
      sts   RTC_PITCTRLA, r18           ; Set PIT Control A
  POP  r20
ENDF HAL_RTC_PIT_CONFIG

; Function: HAL_RTC_PIT_OFF
; Description: Disables the PIT and clears its interrupts.
; Inputs:  None
; Outputs: None
FUNC HAL_RTC_PIT_OFF
      sts   RTC_PITCTRLA, __zero_reg__  ; Disable PIT
      sts   RTC_PITINTCTRL, __zero_reg__ ; Disable PIT Interrupts
      sts   RTC_PITINTFLAGS, __zero_reg__ ; Clear PIT Flags
ENDF HAL_RTC_PIT_OFF

; -----------------------------------------------------------------------------
; Convenience Wrappers
; -----------------------------------------------------------------------------

; Function: RTC_INIT_ONE_SECOND
; Description: Configures RTC for a 1-second overflow period at /256.
FUNC RTC_INIT_ONE_SECOND
    HAL_RTC_INIT_MS 1000, 4096, RTC_PRESCALER_DIV4096_gc
ENDF RTC_INIT_ONE_SECOND

; Function: RTC_INIT_THREE_SECOND
; Description: Configures RTC for a 3-second overflow period at /256.
FUNC RTC_INIT_THREE_SECOND
    HAL_RTC_INIT_MS 3000, 4096, RTC_PRESCALER_DIV4096_gc
ENDF RTC_INIT_THREE_SECOND
