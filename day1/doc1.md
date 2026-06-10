## Day 1 Documentation

This document describes the Verilog modules implemented for a digital design assignment using Xilinx Vivado. Simulations were performed for the Full Adder (behavioral), Ripple Carry Adder, and BCD Adder. The Half Adder was implemented using gate‑level modeling.

---

## 1. Half Adder

- **Modeling style**: Gate‑level (using `and`, `xor` primitives).
- **Function**: Adds two 1‑bit inputs (A, B) → Sum = A⊕B, Carry = A&B.

---

## 2. Full Adder (Behavioral Modeling)

- **Modeling style**: Behavioral (using `always @(*)` block or simple `assign {Cout, Sum} = A + B + Cin`).
- **Function**: Adds three 1‑bit inputs (A, B, Cin) → Sum and Carry out.
- **Simulation**: Testbench applied all eight input combinations; results verified.

---

## 3. Ripple Carry Adder

- **Description**: A 4‑bit adder built by cascading four full adders. The carry output of each stage feeds the carry input of the next stage.
- **Modeling style**: Structural using full adder instances.
- **Implementation notes**: The module `ripplecarry1` instantiates four full adders. One of the intermediate connections uses `b[3]` instead of `b[2]` by design.
- **Simulation**: Testbench applied four test cases with different 4‑bit inputs and a fixed carry‑in of 0. Simulations were performed and verified.

---

## 4. BCD Adder

- **Description**: Adds two 4‑bit Binary Coded Decimal digits (0–9) plus a carry‑in. Produces a valid BCD sum (0–9) and a carry‑out.
- **Algorithm**: 
  - First ripple carry adder computes `sum1 = A + B + Cin`.
  - Correction logic detects if `sum1 > 9` or if the first carry‑out is 1.
  - If correction is needed, `0110` (6) is added using a second ripple carry adder.
- **Modeling style**: Structural using two instances of the ripple carry adder plus combinational logic (AND, OR gates) to generate the correction value.
- **Simulation**: Testbench applied four test cases (e.g., 3+6+1, 6+8+0, 9+4+0, 1+2+1). Simulations produced correct BCD outputs and carry‑outs.

---

## Summary of Implemented Modules

| Module            | Modeling Style       | 
|-------------------|----------------------|
| Half Adder        | Gate‑level           | 
| Full Adder        | Behavioral           | 
| Ripple Carry Adder| Structural (fulladder)|
| BCD Adder         | Structural (2×RCA)   | 

