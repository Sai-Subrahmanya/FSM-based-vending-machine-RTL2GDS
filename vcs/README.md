# VCS — RTL Functional Verification

This directory contains the RTL design and SystemVerilog testbench used for functional verification before synthesis.

## Files

```text
vcs/
├── vending_machine.v
└── tb_vending_machine_compare.sv
```

### `vending_machine.v`

RTL implementation of the FSM-based vending machine.

### `tb_vending_machine_compare.sv`

Self-checking SystemVerilog testbench used to verify the RTL functionality.

---

## Verification Flow

### Step 1 — Compile

Run these in the terminal of the `vcs` directory:

```bash
vcs -full64 -sverilog -debug_all vending_machine.v tb_vending_machine_compare.sv -l compile_rtl.log
```

### Step 2 — Simulate

```bash
./simv -l sim_rtl.log
```

### Step 3 — Check the Simulation Result

```bash
grep -i "ALL VENDING MACHINE TESTS PASSED\|ERROR\|FATAL" sim_rtl.log
```

A successful simulation reports:

```text
ALL VENDING MACHINE TESTS PASSED
```

---

## DVE Waveform Analysis

The generated VPD file can be opened using:

```bash
dve -full64 -vpd vending_machine_compare.vpd &
```

The waveform analysis procedure is:

1. Open the testbench hierarchy.
2. Locate the DUT instance.
3. Select the required signals.
4. Right-click and select **Add to New Wave View**.
5. Use **Zoom Full**.
6. Change signal radix using **Set Radix** when required.

The waveform provides visual confirmation of the RTL behavior.

---

## Verification Scope

The testbench covers:

- Reset
- FSM state transitions
- Valid inputs
- Invalid inputs
- Refund behavior
- Vending behavior
- Change generation
- Back-to-back transactions
- Reset during a transaction

RTL functional verification is completed before synthesis.

Post-synthesis and post-layout gate-level simulation is not included because the required SAED32 standard-cell functional Verilog simulation models were not available in the accessible project environment.
