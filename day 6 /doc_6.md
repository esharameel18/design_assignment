# Day 6 - FIFO Transaction Class

This document summarizes the SystemVerilog random testbench components created for FIFO verification. These files generate constrained random stimulus and are used to test the FIFO module.

---

## Task: FIFO Random Transaction Class

### `fifo_transaction` Class
- **Purpose**: Encapsulates a FIFO transaction with randomizable control and data fields. Used to generate stimulus for the FIFO DUT.
- **Fields**:
  - `rst_n` – Reset (active‑low), random.
  - `wr_en` – Write enable, random.
  - `rd_en` – Read enable, random.
  - `data_in` – 8‑bit write data, random.
  - `data_out` – 8‑bit read data (expected to be driven by DUT, not randomized).
  - `full`, `empty` – FIFO status flags (driven by DUT, not randomized).
- **Constraints** (distributions):
  - `rst_n`: 20% chance of being 0, 80% chance of being 1.
  - `wr_en`: 30% chance of 0, 70% chance of 1.
  - `rd_en`: 70% chance of 0, 30% chance of 1.
  - `data_in`: 10% chance of values between 1–10, 90% chance of values between 11–255 (weighted distribution).
- **Method**:
  - `display()`: Prints all fields in a readable format for simulation logging.

### `fifo_tb` Testbench
- **Purpose**: Instantiates the transaction class and exercises it.
- **Behavior**:
  1. Creates a new `fifo_transaction` object.
  2. Loops 10 times, calling `randomize()` on the object each iteration.
  3. Calls `display()` to print the randomized values.
- **Usage**: This is a proof‑of‑concept testbench to demonstrate random constraint generation; it does not connect to a DUT but can be extended to drive actual FIFO signals.

---

## Summary

| File                  | Purpose                                   |
|-----------------------|-------------------------------------------|
| `fifo_transaction.sv` | Defines randomized transaction class with constraints |
| `tb.sv`               | Instantiates class, randomizes and displays 10 transactions |

This approach forms the foundation for a constrained‑random verification environment for the FIFO module.
