# Register Usage & The HAL Social Contract

The HAL enforces a strict register usage contract to prevent clashing across drivers and user code:

## Register Mapping & Preservation Rules

| Register | Name / Usage | Preserved? | Rules & Invariants |
| :--- | :--- | :--- | :--- |
| **`r0, r1`** | `__scratch0__`, `__scratch1__` | **Volatile** | Used by `mul` and math routines. Do not assume persistence across calls. |
| **`r2`** | `__zero_reg__` | **Permanent ($00)** | Initialized by HAL startup. **NEVER overwrite or use as destination.** |
| **`r3`** | `__full_reg__` | **Permanent ($FF)** | Initialized by HAL startup. **NEVER overwrite or use as destination.** |
| **`r4 – r15`** | Callee-Saved Registers | **Preserved** | Must be preserved with `push`/`pop` if modified inside any routine. |
| **`r16 – r17`** | Scratch Registers | **Volatile** | Caller-saved scratchpad. Typically used for local `ldi` or intermediate values. |
| **`r18 – r21`** | Callee-Saved Registers | **Preserved** | Must be preserved with `push`/`pop` if modified. |
| **`r22 – r25`** | Arguments & Return Values | **Volatile** | 8-bit (`r22`), 16-bit (`r23:r22`), 32-bit (`r25:r22`). Carry flag indicates status/success. |
| **`X (r27:r26)`** | Streaming Pointer | **Preserved** | Primary pointer for data arrays, buffers, and string streams. Callee-saved. |
| **`Y (r29:r28)`** | Hardware / I/O Pointer | **Preserved** | Stores peripheral base addresses. Callee-saved. |
| **`Z (r31:r30)`** | Instance Handle / Context | **Preserved\*** | Points to active SRAM descriptor / `self`. (*Modified only by explicit selector routines). |

## Peripheral Tiering Rules

1. **Tier A (Streaming - USART, USB)**: Requires an SRAM Ring/Double Buffer descriptor and an active `Z` instance handle.
2. **Tier B (Control - TWI, SPI, TCA/TCE, ADC)**: Requires a 2-byte handle in SRAM containing the peripheral base address. Synchronous and multi-instance capable.
3. **Tier C (System - WDT, CLKCTRL, SLPCTRL, VREF)**: Singleton resources; direct macro calls and static dispatch (no handles).
