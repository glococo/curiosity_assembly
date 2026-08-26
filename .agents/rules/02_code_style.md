# Assembly Code Style & Documentation Conventions

Follow these assembly coding patterns, docblock headers, and visual column alignments throughout the codebase (reference implementation: `hal/core/devicebuffer.S`):

---

## 1. File Header Template

Every source file must start with a standardized header describing its purpose and memory/hardware structures:

```assembly
; File: hal/core/devicebuffer.S
; Description: High-performance Byte Ring Buffer (Circular Buffer).
;              Uses Power-of-Two sizes (2, 4, 8, ..., 256) for optimized wrapping.
;
; Buffer Structure in SRAM (if applicable):
; [Offset 0] Head (Write index)
; [Offset 1] Tail (Read index)
; [Offset 2] Mask (Size - 1)
; [Offset 3] Device Address L
; [Offset 4] Device Address H
; [Offset 5] Data... (Size bytes)
```

---

## 2. Function & Macro Docblocks

Every function or macro definition must document its inputs, outputs, and status flags (especially Carry Flag `Cf`):

```assembly
; Function: HAL_DEVICEBUFFER_PUSH
; Description: Adds a single byte to the buffer.
; Inputs:    Z - Points to Buffer Structure
;          r22 - Value to store
; Outputs:  Cf - Clear: Full, Set: Success
FUNC HAL_DEVICEBUFFER_PUSH
  PUSH_MANY r24, r25, XL, XH
    ld      r25, Z                      ; r25 = Current Head
    ldd     r26, Z+1                    ; r26 = Current Tail
    ...
    sec                                 ; Set Carry: Success
  0:
  POP_MANY XH, XL, r25, r24
ENDF HAL_DEVICEBUFFER_PUSH
```

---

## 3. Visual Layout & Column Alignment

1. **4-Space Indentation**: Indent instructions inside `FUNC`/`ENDF`, `ISR_START`/`ISR_END`, and `.macro` blocks.
2. **Push/Pop Scoping**: Align `PUSH_MANY`/`POP_MANY` at the outer function indent (2 spaces) and indent the core logic (4 spaces) for clear stack frame visibility.
3. **Column-Aligned Comments**: Align inline `;` comments to column 40–45 for effortless reading.
4. **Local Labels**: Use numeric labels (`0:`, `1:`) with forward/backward jumps (`rjmp 0f`, `breq 1b`).
5. **Macro Labels**: Always append `\@` (e.g. `1\@:`) inside macros to prevent duplicate symbols.

---

## 4. Strings & Constant Storage

- **Flash vs SRAM**: Never store constant strings or lookup tables in `.data` (wastes SRAM).
- **`ASCIZ` Macro**: Place strings in `.progmem.rodata` using `ASCIZ name, "string"`. This automatically generates the `name_len` constant.
- **Unified Memory Map**: Strings in `.progmem.rodata` are accessible via standard `ld` offset by `MAPPED_PROGMEM_START`.

---

## 5. Extended ISA Macros

Prefer extended multi-byte macros (`hal/core/extend.S`) over manual 8-bit instruction sequences:
- `ldi2 r24, 0x1234` / `ldi4 r22, 0x12345678`
- `lds2 r24, var16` / `sts4 var32, r22`
- `add2 r24, r22` / `add4 r20, r22` / `cp2 r24, r22`
- `lsli2 r24, 4` / `andi2 r24, 0x00FF`
