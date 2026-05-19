# AVR Assembly HAL: Buffer Implementations

This document details the technical implementation and selection criteria for the two primary buffering strategies provided by this HAL.

---

## 1. HAL_DEVICEBUFFER (Circular / Ring Buffer)
A classic power-of-two ring buffer designed for asynchronous byte streams (e.g., USART, I2C).

### Technical Specification
- **Descriptor (5 bytes)**:
  - `[0]` Head: Write index (0-255).
  - `[1]` Tail: Read index (0-255).
  - `[2]` Mask: (Buffer Size - 1). Used for fast wrap-around.
  - `[3-4]` Device Address: 16-bit base address of the associated peripheral.
- **Constraints**: Size **must** be a power of two (8, 16, 32, 64, 128, 256).
- **Status Signaling**: Uses the **Carry Flag** (`Set` = Success/Not Empty, `Clear` = Full/Empty).

### Characteristics
- **Memory Efficient**: Low overhead (1x data size + 5-byte descriptor).
- **Stream-Oriented**: Data can be pushed and pulled byte-by-byte asynchronously.
- **Moderate Speed**: Requires loading Head/Tail and Masking for every operation.

---

## 2. HAL_DOUBLEBUFFER (Ping-Pong / Double Buffer)
A block-oriented buffering strategy designed for high-throughput data processing and "Zero-Copy" potential.

### Technical Specification
- **Descriptor (9 bytes)**:
  - `[0-1]` Active Write Pointer: 16-bit address of the next free byte.
  - `[2-3]` Active Base Address: 16-bit start address of the buffer currently being filled.
  - `[4-5]` Spare Base Address: 16-bit start address of the buffer currently being drained.
  - `[6]`   Buffer Limit: Size of an individual buffer (0-255).
  - `[7]`   Bytes Written in Active: Counter for current filling.
  - `[8]`   Bytes Ready in Spare: Counter for bytes remaining in the processed block.
- **Constraints**: Size can be any value from 2 to 256.
- **Status Signaling**: Signals "Full" and performs an automatic `FLIP` once the limit is reached.

### Characteristics
- **High Performance**: `PUSH` operation is extremely fast (direct store with post-increment).
- **Block-Oriented**: Ideal for processing data in fixed-size chunks (e.g., 64-byte packets).
- **Zero-Copy Potential**: The Spare buffer can be handed off to a processing loop while the Active buffer continues to collect data.
- **Higher SRAM Cost**: Requires double the data storage (2x size + 9-byte descriptor).

---

## 3. Comparison Summary

| Feature         | HAL_DEVICEBUFFER                      | HAL_DOUBLEBUFFER                      |
|-----------------|---------------------------------------|---------------------------------------|
| **Primary Use** | General purpose byte streams (USART)  | High-speed block transfers / DMA-like |
| **ISR Speed**   | Fast (Masking overhead)               | **Fastest** (Simple pointer inc)      |
| **SRAM Cost**   | **Low** (1x size + 5)                 | High (2x size + 9)                    |
| **Data Flow**   | Continuous / Asynchronous             | Block-based (Full/Empty)              |
| **Size Constraint**| Power-of-Two only                  | 2 to 256 bytes                        |

### Selection Recommendation
- **Use `HAL_DEVICEBUFFER`** for standard terminal I/O, command parsers, and low-to-medium speed communication where memory efficiency is prioritized.
- **Use `HAL_DOUBLEBUFFER`** for high-speed ADC sampling, SPI sensors, or high-baud USART where minimizing ISR latency is critical and data arrives in fixed packets.
