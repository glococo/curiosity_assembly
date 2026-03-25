
FUNC main
    rcall   HAL_BOARD_SETUP             ; Basic board initialization

    ; 1. Set OSCHF to 16 MHz (Typical requirement for PLL)
    ldi     r22, HAL_CLKCTRL_FREQ_16MHZ
    rcall   HAL_CLKCTRL_OSCHF_SET

    ; 2. Configure PLL
  #ifdef CLKCTRL_USBPLLSTATUS
    ; AVR DU: Enable USB PLL from OSCHF
    ldi     r22, HAL_CLKCTRL_PLL_ENABLE | HAL_CLKCTRL_PLL_SRC_OSCHF
  #else
    ; AVR DB/EB: Set multiplier (e.g., 3x for DB -> 48 MHz)
    ; Note: MULFAC values might vary between DB and EB.
    ; Using a safe value for DB (3x)
    ldi     r22, HAL_CLKCTRL_PLL_MUL_8 | HAL_CLKCTRL_PLL_SRC_OSCHF
  #endif
    rcall   HAL_CLKCTRL_PLL_SET

    ; 3. Wait for PLL to lock
    rcall   HAL_CLKCTRL_PLL_WAIT

    ; 4. Switch to PLL if supported as Main Clock (AVR DU)
  #ifdef CLKCTRL_USBPLLSTATUS
    ldi     r22, HAL_CLKCTRL_SRC_PLL
    rcall   HAL_CLKCTRL_MAIN_SELECT
    ; Update timing constants for 48 MHz (assuming 16MHz * 3 or similar)
    ; HAL_CLKCTRL_PRESCALER expects BOARD_CLOCK_MAIN to be correct.
  #endif

  loop:
    ; Toggle LED to show we are alive
    ldi     r18, BOARD_LED_PIN
    sts     _(BOARD_LED_PORT, _OUTTGL), r18
    HAL_DELAY_MS 500
    rjmp    loop
ENDF main
