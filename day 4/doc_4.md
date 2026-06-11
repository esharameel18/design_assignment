## Day 4 - Memory Generator – Documentation

This document summarizes the Verilog module `mem_generator` implemented as part of today's task. The module is a simple 8‑depth memory with separate write and read ports. It has been verified with a testbench.

---

## Module Description

### `mem_generator` – Dual‑Port Memory with Asynchronous Reset

- **Function**: Implements an 8‑location memory (each location 8 bits wide). Supports simultaneous write and read operations on the same clock cycle. Write is enabled by `wr_en`. Read address is independent of write address.
- **Interface**:
  - `clk` – Clock input
  - `arstn` – Asynchronous active‑low reset (clears memory and output)
  - `wr_en` – Write enable (high to write)
  - `wr_add[2:0]` – Write address
  - `rd_add[2:0]` – Read address
  - `datain[7:0]` – Data to write
  - `dataout[7:0]` – Data read from `rd_add`
- **Behavior**:
  - On reset (`arstn = 0`), all memory locations are cleared to 0 and `dataout` is set to 0.
  - On rising clock edge:
    - If `wr_en = 1`, data is written to `mem[wr_add]`.
    - Regardless of write, `dataout` is updated with the current value at `rd_add` (read data).
- **Modeling style**: Behavioral – using an `always @(posedge clk or negedge arstn)` block with a `for` loop for reset and conditional write/read assignments.

---

## Testbench Verification

### `mem_generator_tb` – Simulation Testbench

- **Purpose**: Verify write and read operations of the memory.
- **Test sequence**:
  1. Assert reset (`arstn = 0`) for 10 time units, then de‑assert.
  2. Write `8'b00000001` to address `3'b001`.
  3. Write `8'b00000101` to address `3'b011`.
  4. Write `8'b00001111` to address `3'b101`.
  5. Disable write (`wr_en = 0`).
  6. Read from address `3'b001` (expect `0x01`).
  7. Read from address `3'b011` (expect `0x05`).
  8. Read from address `3'b101` (expect `0x0F`).
- **Clock generation**: 10‑unit period toggle.
- **Result**: Simulation waveforms confirm correct write and read operations – the module behaves as expected.

---

## Summary

| Module            | Purpose                          | Verification |
|-------------------|----------------------------------|--------------|
| `mem_generator`   | 8×8 dual‑port memory with async reset | Testbench    |
