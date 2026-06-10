# Day 3 – Documentation

This document summarizes the Verilog modules implemented as part of a face detection system and a sequence detector task. All modules have been verified with testbenches.

---

## Face Detection System

The system processes incoming 8‑bit pixel data from a face sensor, stores it in a FIFO, and outputs valid data under FSM control.

### 1. `face_sensor` – Sensor Interface
- **Function**: Simple register that captures the input `sin` (8‑bit pixel data) on each clock edge and outputs it as `sout` on the next cycle.
- **Modeling style**: Behavioral (always @(posedge clk)).
- **Role**: Models a basic sensor with one‑cycle latency.

### 2. `fifo_face` – Synchronous FIFO Buffer
- **Depth**: 8 entries, each 8 bits wide.
- **Function**: Stores incoming data when `wrenb` is asserted (if not full). Outputs data when `rdenb` is asserted (if not empty). Provides `full` and `empty` flags.
- **Implementation details**: Uses separate write and read pointers, a `count` register to track occupancy, and a memory array. Handles simultaneous read and write when both conditions are safe.
- **Modeling style**: Register‑based behavioral with reset logic.

### 3. `FSM_module` – Output Control Finite State Machine
- **States**: `S_CLK1`, `S_CLK2`, `S_CLK3` (3‑state sequence).
- **Function**:
  - In `S_CLK1`: If FIFO not empty, asserts `fifo_rdenb` to read data.
  - In `S_CLK2`: Waits one clock cycle (no read).
  - In `S_CLK3`: Latches the FIFO output as `dout` and asserts `dout_valid` for one cycle.
- **Outputs**: `dout` (8‑bit processed data), `dout_valid` (valid flag), `fifo_rdenb` (read enable to FIFO).
- **Modeling style**: Mealy/Moore hybrid – next state is combinational, outputs are registered.

### 4. `top_module` – System Integration
- **Connects**: `face_sensor` → `fifo_face` → `FSM_module`.
- **Inputs**: `clk`, `rst`, `wrenb` (write enable from external), `sin` (sensor data).
- **Outputs**: `dout`, `dout_valid`, `fifo_full`, `fifo_empty`.
- **Function**: Routes sensor output to FIFO data input, FIFO output to FSM, and FSM outputs to top‑level. Also exposes FIFO status flags.

---

## Sequence Detector (Day 3 Task)

### `seq_detect` – Overlapping Sequence Detector
- **Function**: Detects the overlapping sequence `"1110"` on a serial input `din`.
- **Output**: `det` goes high for one clock cycle when the third sequence is detected (overlapping allowed).
- **States**: `idle`, `s1` (one `1` detected), `s2` (two `1`s detected), `s3` (three `1`s detected).
- **Verification**: Testbench applied various input patterns; simulation confirmed correct detection.

---

## Summary of Modules

| Module           | Purpose                          | 
|------------------|----------------------------------|
| `face_sensor`    | Register sensor data             | 
| `fifo_face`      | 8‑deep FIFO buffer               | 
| `FSM_module`     | Controls data output timing      |
| `top_module`     | Integrates all blocks            | 
| `seq_detect`     | Detects "111" overlapping sequence| 
