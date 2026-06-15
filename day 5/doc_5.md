## Day 5 – Documentation

This document summarizes two tasks: a synchronous FIFO design tested with a SystemVerilog interface, and a BCD adder tested similarly. Both have been verified with testbenches.

---

## Task 1: Synchronous FIFO with Interface

### `fifo` Module
- **Depth**: 8 entries, each 8 bits wide.
- **Function**: Standard synchronous FIFO. Writes when `wrenb` is high and not full. Reads when `rdenb` is high and not empty. Provides `full` and `empty` flags.
- **Reset**: Synchronous clear of memory contents.
- **Implementation notes**: Uses separate write and read pointers. Full/empty flags are derived combinatorially from pointer values.
- **Modeling style**: Behavioral.

### `fifo_if` Interface
- **Purpose**: Encapsulates all FIFO signals (`clk`, `rst`, `wrenb`, `rdenb`, `datain`, `dataout`, `full`, `empty`) into a reusable block.

### `fifo_interfacing` Testbench
- **Function**: Instantiates the interface and DUT, connects via interface. Applies a test sequence:
  - Reset, then write five values (`2`, `4`, `6`, `8`, `10` in decimal) to the FIFO.
  - Then read back by setting `rdenb`.
- **Verification**: `$monitor` captures signal values. Simulation confirms correct write and read operations.

---

## Task 2: BCD Adder with Interface

### `BCD` Module
- **Function**: Adds two 4‑bit BCD digits (0‑9) plus a carry‑in. Produces valid BCD sum and carry‑out.
- **Implementation**: Uses two ripple carry adders and correction logic (adds 6 if sum > 9 or carry‑out from first adder is 1). Refer to previous BCD adder documentation for details.

### `bcd_if` Interface
- **Purpose**: Groups BCD adder ports (`A`, `B`, `C`, `sum`, `cout`) into a single interface.

### `bcd_interface` Testbench
- **Function**: Instantiates interface and DUT. Applies four test cases:
  - 3 + 6 + 1 = 10 → sum 0, cout 1
  - 6 + 8 + 0 = 14 → sum 4, cout 1
  - 9 + 4 + 0 = 13 → sum 3, cout 1
  - 1 + 2 + 1 = 4 → sum 4, cout 0
- **Verification**: `$monitor` logs results. Simulation matches expected BCD outputs.

---

## Summary

| Task                  | Modules                          | 
|-----------------------|----------------------------------|
| FIFO with interface   | `fifo`, `fifo_if`, testbench     |
| BCD adder with interface | `BCD`, `bcd_if`, testbench   | 
