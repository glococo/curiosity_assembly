---
name: math-verification
description: >-
  Validate and test 16-bit, 32-bit, and 64-bit mathematical and shifting routines.
---

# Mathematical Library Verification

Use this skill when modifying, debugging, or adding new routines to `hal/math/*.S` (Multiplication, Division, Shifts, Casts).

## 1. Running the Automated Math Suite

Flash `examples/06_math_lib/main.S` to an available Curiosity Nano board:

```bash
./curiosity.sh avr128da48_cnano examples/06_math_lib/main.S
```

The test runner will execute diagnostic test vectors and output results over UART at 38400 baud.

## 2. Test Verification Checklist

When adding or updating routines:
1. **Multiplication (`hal/math/mul.S`)**: Test signed and unsigned multiplication across 16x16, 32x32, 64x64 bits. Check corner cases (zero, max positive, max negative, -1).
2. **Division (`hal/math/div.S`)**: Test division by 1, division by zero handling, and quotient/remainder correctness for signed and unsigned integers.
3. **Bitwise Shifts (`hal/math/shifts.S`)**: Test shift counts of 0, 1, byte-multiples (8, 16, 24, 32), and edge counts (> register width).
4. **Zero Register Contract**: Verify that `r2` (`__zero_reg__`) remains strictly `$00` and `r3` (`__full_reg__`) remains `$FF` after executing any routine.
