# AVR GNU Assembler: Sections and Data Directives

This document summarizes how this HAL utilizes memory sections and data allocation for modern AVR (Dx/Ex) microcontrollers.

## 1. Memory Sections Summary

| Section            | Location | Typical Use Case |
|--------------------|----------|------------------|
| `.text.<name>`     | Flash    | Executable code. Using sub-sections allows for `--gc-sections` optimization. |
| `.progmem.rodata`  | Flash    | Read-only constants and strings. |
| `.data`            | SRAM     | Initialized variables (copied from Flash at boot). |
| `.bss`             | SRAM     | Uninitialized global variables (cleared at boot). Used by `_DEVBUFFER`. |
| `.noinit`          | SRAM     | Variables that survive software reset. |
| `.eeprom`          | EEPROM   | Non-volatile configuration. |
| `.fuse`            | Fuses    | Hardware configuration. |

---

## 2. String and Data Management

### Unified Memory Mapping (Dx/Ex)
Modern AVRs map Flash into the SRAM address space. This HAL leverages this by using `MAPPED_PROGMEM_START` (typically `0x8000` or `0x4000` depending on the device) to access strings using standard `ld` instructions instead of `lpm`.

### The `ASCIZ` Macro
Located in `HAL_MACRO.S`, this is the preferred way to define strings.
```assembly
ASCIZ my_string, "Hello World"
```
- **Section**: Automatically pushes to `.progmem.rodata`.
- **Metadata**: Generates a `my_string_len` constant (excluding null terminator).
- **Storage**: Null-terminates the string automatically.

### Register-Sized Data Types
Since AVR is 8-bit, this HAL uses macros for multi-byte operations. While not "types" in the C sense, these are the standard widths:
- **8-bit**: `.byte`
- **16-bit**: `.short` or `.word` (Accessed via `ldi2`, `lds2`, etc.)
- **32-bit**: `.long` (Accessed via `ldi4`, `lds4`, etc.)

---

## 3. Best Practices for this HAL

1. **Sub-sectioning**: Always use the `FUNC` macro which places code in `.text.function_name`. This ensures that unused functions are removed during the link stage.
2. **Flash for Constants**: Never use `.data` for read-only strings. Use `ASCIZ` or `.pushsection .progmem.rodata`.
3. **Descriptor Initialization**: Large structures (like `HAL_DEVICEBUFFER`) should be defined in `.bss` and initialized at runtime via an `_INIT` function to save Flash space.
4. **Alignment**: The AVR CPU requires word alignment for instructions, but bytes are fine for data. However, for 16-bit or 32-bit data accessed via `lds2/4`, ensure they are placed such that they don't cross page boundaries if performance is critical (though usually not an issue on Dx/Ex).
