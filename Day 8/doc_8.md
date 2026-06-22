# Day 8 - APB 

This document summarizes the APB slave module and its comprehensive SystemVerilog testbench environment. The verification environment follows a structured methodology with generators, drivers, monitors, and scoreboards.

---

## APB Slave Module

### `apb_slave` – APB Protocol Slave
- **Purpose**: Implements a slave device compliant with the AMBA APB (Advanced Peripheral Bus) protocol. Contains a 256‑word memory (each 32 bits wide) accessible via APB read/write transactions.
- **Features**:
  - Supports APB states: `IDLE`, `SETUP`, `ACCESS`.
  - Generates `PREADY` for wait‑state support (always 1 in this implementation).
  - `PSLVERR` asserted for invalid addresses (above `8'hFF`).
  - On write, stores `PWDATA` to memory at `PADDR`.
  - On read, outputs memory contents as `PRDATA`.
- **Interface**: Standard APB signals (`PCLK`, `PRESETn`, `PSEL`, `PENABLE`, `PWRITE`, `PADDR`, `PWDATA`, `PRDATA`, `PREADY`, `PSLVERR`).
- **Reset**: Active‑low asynchronous reset (`PRESETn`).
- **Modeling style**: SystemVerilog with `always_ff` and `always_comb`, using enumerated state types.

---

## Verification Environment

The testbench is built with a modular, class‑based architecture for constrained‑random verification.

### 1. `apb_if` – Interface
- **Purpose**: Encapsulates all APB signals into a reusable interface.
- **Usage**: Connects DUT to testbench components.

### 2. `apb_transaction` – Transaction Class
- **Purpose**: Models a single APB transaction (write or read).
- **Fields**: `addr` (8‑bit), `wdata` (32‑bit write data), `write` (read/write flag), `rdata` (32‑bit read data).
- **Method**: `display()` – prints transaction details for logging.

### 3. `generator` – Stimulus Generation
- **Purpose**: Generates random APB transactions.
- **Behavior**: Repeatedly creates a write transaction followed by a read transaction to the same address (to verify write/read consistency).
- **Parameters**: `count` controls number of iterations.
- **Communication**: Sends transactions to driver via mailbox (`gen2drv`).

### 4. `driver` – Signal Driving
- **Purpose**: Drives APB signals to the DUT based on received transactions.
- **Behavior**:
  - Applies reset sequence.
  - Performs SETUP phase (assert `PSEL`, drive address/control/data).
  - Performs ACCESS phase (assert `PENABLE`, wait for `PREADY`).
  - De‑asserts signals after transaction completion.
- **Communication**: Receives transactions from generator mailbox.

### 5. `monitor` – Signal Monitoring
- **Purpose**: Observes APB bus activity and captures completed transactions.
- **Behavior**: Detects `PSEL`, `PENABLE`, and `PREADY` simultaneously active; captures address, write/read flag, and data.
- **Communication**: Sends captured transactions to scoreboard via mailbox (`mon2scb`).

### 6. `scoreboard` – Self‑Checking Verification
- **Purpose**: Compares DUT behavior against a reference model.
- **Reference model**: Internal memory array (`ref_mem`) that mirrors expected DUT memory.
- **Behavior**:
  - On write: Updates reference memory.
  - On read: Compares DUT output (`rdata`) with reference value; increments `pass_count` or `fail_count`.
- **Logging**: Displays PASS/FAIL results for each transaction.

### 7. `environment` – Testbench Container
- **Purpose**: Instantiates and connects all verification components.
- **Components**: Generator, driver, monitor, scoreboard.
- **Communication**: Creates mailboxes for inter‑component data transfer.

### 8. `test` – Test Configuration
- **Purpose**: Top‑level test class.
- **Configuration**: Sets generator count to 10 transactions.
- **Execution**: Starts environment components, waits for completion, and reports pass/fail statistics.

### 9. `apb_program` – Program Block
- **Purpose**: SystemVerilog program block that instantiates and runs the test.
- **Execution**: Creates test object and calls `run()` on startup.

### 10. `tb` – Top‑Level Module
- **Purpose**: Top simulation module.
- **Function**:
  - Generates 100MHz clock (10ns period).
  - Instantiates APB interface and DUT.
  - Applies reset (active‑low for 20ns).
  - Instantiates the test program.
  - Dumps VCD waveform for debugging.

---

## Verification Flow

1. **Generator** creates random write+read pairs.
2. **Driver** drives transactions to DUT via APB interface.
3. **DUT** processes transactions.
4. **Monitor** captures bus activity.
5. **Scoreboard** checks correctness against reference model.
6. **Report** displays pass/fail counts after all transactions.

---

## Summary

| Component          | Purpose                                   |
|--------------------|-------------------------------------------|
| `apb_slave`        | APB slave with 256×32 memory              |
| `apb_if`           | Interface for APB signals                 |
| `apb_transaction`  | Transaction data container                |
| `generator`        | Creates random write+read pairs           |
| `driver`           | Drives APB signals to DUT                 |
| `monitor`          | Captures bus transactions                 |
| `scoreboard`       | Compares DUT outputs with reference       |
| `environment`      | Connects all testbench components         |
| `test`             | Configures and runs the test              |
| `tb`               | Top‑level simulation module               |
