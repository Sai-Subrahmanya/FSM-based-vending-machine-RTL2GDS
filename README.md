# FSM Based Vending Machine — RTL2GDS

An FSM-based vending machine implemented through a complete RTL-to-GDS digital IC design flow using Synopsys VCS, Design Compiler, and IC Compiler II with the SAED32 32 nm technology.

---

## Project Overview

This project demonstrates the implementation of a finite-state-machine-based vending machine from RTL design through physical design.

The complete flow consists of:

1. RTL design
2. RTL functional verification using Synopsys VCS
3. Waveform inspection using Synopsys DVE
4. Logic synthesis using Synopsys Design Compiler
5. Floorplanning using Synopsys IC Compiler II
6. Power planning
7. Placement
8. Clock-tree synthesis and analysis
9. Routing
10. Filler-cell insertion
11. Power/ground connectivity checks
12. Physical-design and signoff-oriented report analysis

The design uses the SAED32 RVT standard-cell library at the typical operating condition of 0.85 V and 25 °C.

---

## Design Description

The vending machine is implemented as a finite state machine (FSM).

The design contains three primary transaction states representing the accumulated monetary value:

| State | Accumulated Value |
|---|---:|
| `S0` | ₹0 |
| `S1` | ₹5 |
| `S2` | ₹10 |

The design accepts coin/input combinations and generates:

- `out` — vending/output indication
- `change` — returned change

The RTL handles:

- Reset behavior
- State transitions
- Valid coin inputs
- Invalid input conditions
- Refund conditions
- Vending conditions
- Change generation
- Back-to-back transactions

---

## Repository Structure

```text
fsm-based-vending-machine-rtl2gds/
│
├── README.md
│
├── vcs/
│   ├── README.md
│   ├── vending_machine.v
│   └── tb_vending_machine_compare.sv
│
├── dc/
│   ├── README.md
│   ├── source/
│   ├── scripts/
│   ├── reports/
│   ├── results/
│   └── work/
│
├── icc2/
│   ├── README.md
│   ├── source/
│   ├── scripts/
│   ├── reports/
│   ├── results/
│   └── work/
│
├── ref/
│   ├── README.md
│   ├── lib/
│   │   └── README.md
│   └── tech/
│       └── README.md
│
└── images/
    ├── README.md
    └── screenshots/
```

---

# RTL Functional Verification

RTL functionality was verified before synthesis using Synopsys VCS and a self-checking SystemVerilog testbench.

The testbench verifies multiple functional scenarios, including:

- Reset behavior
- FSM state transitions
- Valid coin inputs
- Invalid inputs
- Refund conditions
- Vending conditions
- Change generation
- Back-to-back transactions
- Reset during a transaction

### VCS Compilation

Run the following command from the `vcs` directory:

```bash
vcs -full64 -sverilog -debug_all vending_machine.v tb_vending_machine_compare.sv -l compile_rtl.log
```

### Simulation

```bash
./simv -l sim_rtl.log
```

### Test Result Check

```bash
grep -i "ALL VENDING MACHINE TESTS PASSED\|ERROR\|FATAL" sim_rtl.log
```

A successful functional verification run reports:

```text
ALL VENDING MACHINE TESTS PASSED
```

---

# DVE Waveform Analysis

The VPD waveform generated during VCS simulation can be opened using Synopsys DVE:

```bash
dve -full64 -vpd vending_machine_compare.vpd &
```

The waveform analysis procedure used in this project is:

1. Open the testbench hierarchy.
2. Locate the DUT instance.
3. Select the required signals from the variable window.
4. Right-click and select **Add to New Wave View**.
5. Use **Zoom Full** to fit the waveform.
6. Signals can be assigned different radix formats using **Set Radix**.

The waveform is used to visually inspect the relationship between:

- Clock
- Reset
- Input
- FSM state
- Output
- Change

---

# RTL-to-GDS Flow

```text
                    RTL Design
                        │
                        ▼
              VCS Functional Verification
                        │
                        ▼
                Design Compiler
                        │
          ┌─────────────┼─────────────┐
          ▼             ▼             ▼
        Timing         Area          Power
          │             │             │
          └─────────────┼─────────────┘
                        ▼
                    ICC2
                        │
                        ▼
                  Floorplanning
                        │
                        ▼
                  Power Planning
                        │
                        ▼
                    Placement
                        │
                        ▼
              Clock Tree Synthesis
                        │
                        ▼
                     Routing
                        │
                        ▼
                 Filler Insertion
                        │
                        ▼
             Physical Verification
                        │
                        ▼
                Final Reports/GDS
```

---

# Design Compiler — Logic Synthesis

The verified RTL is synthesized using Synopsys Design Compiler.

The synthesis flow is controlled by:

```text
dc/scripts/synth_vending_machine.tcl
```

The design constraints are defined in:

```text
dc/source/vending_machine.sdc
```

### DC Launch

From the `dc/work` directory:

```bash
dc_shell -gui
```

Then, from the Design Compiler command prompt:

```tcl
source ../scripts/synth_vending_machine.tcl
```

### Synthesis

The synthesis flow performs RTL elaboration, technology mapping, optimization, constraint application, and report generation.

The flow uses `compile_ultra` followed by incremental compilation.

### Main DC Reports

The synthesis flow generates reports covering:

- Area
- Power
- Constraints
- Quality of Results (QoR)
- Timing

The reports are stored in:

```text
dc/reports/
```

### DC Results

The synthesis flow generates the synthesized design and constraint files in:

```text
dc/results/
```

The synthesized Verilog and SDC are automatically copied to:

```text
icc2/source/
```

for use by IC Compiler II.

---

# Design Constraints

The design uses the following primary clock constraint:

```text
Clock Period: 5 ns
```

The operating condition used for the design is:

```text
Process:      TT
Voltage:      0.85 V
Temperature:  25 °C
```

The SDC also specifies clock uncertainty, input/output delays, input transition, and output loading.

The complete constraints are available in:

```text
dc/source/vending_machine.sdc
```

---

# IC Compiler II — Physical Design

The synthesized design is taken through physical implementation using Synopsys IC Compiler II.

The physical-design flow is divided into multiple TCL scripts.

### ICC2 Scripts

```text
icc2/scripts/
├── common_setup.tcl
├── floorplan.tcl
├── power_plan.tcl
├── pg_repair.tcl
├── placement.tcl
├── clock.tcl
├── route.tcl
├── fillers.tcl
├── reports.tcl
└── run_all.tcl
```

### ICC2 Launch

From the `icc2/work` directory:

```bash
icc2_shell -gui
```

The complete physical-design flow can be executed using:

```tcl
source ../scripts/run_all.tcl
```

The scripts can also be executed individually when required.

---

# Physical Design Stages

The ICC2 flow includes:

### 1. Floorplanning

The design is initialized and the core/floorplan is created according to the specified utilization and boundary constraints.

### 2. Power Planning

Power and ground structures are created, including the required power rings, mesh structures, and standard-cell power connections.

### 3. Placement

Standard cells are placed within the core region and placement optimization is performed.

### 4. Clock Tree Synthesis

The clock network is synthesized and optimized to distribute the clock signal through the design.

### 5. Routing

The design undergoes global and detailed routing.

### 6. Filler Insertion

Filler cells are inserted to maintain physical and well continuity requirements.

### 7. PG Repair and Connectivity

Power/ground connectivity is checked and repaired where required.

### 8. Final Reporting

Final timing, area, power, QoR, congestion, routing, clock, and physical-design reports are generated.

---

# Clock Tree Analysis

The clock tree was inspected using the ICC2 graphical interface.

The procedure used was:

1. Select **Highlight → Color By → Clock Tree**.
2. Open the Clock Tree window.
3. Select the clock.
4. Click **Apply**.
5. Open **Window → Clock Tree Analysis Window**.
6. Right-click the clock.
7. Select **Clock Tree Latency Graph of Selected Corner**.
8. Click **OK**.
9. Right-click the clock and select **Expand All**.
10. Use **Highlight Longest Path from Source**.
11. Use **Highlight Shortest Path from Source**.

This provides visual inspection of clock-tree topology and latency paths.

---

# Reference Technology and Library

The project uses the SAED32 32 nm technology with the SAED32 RVT standard-cell library.

The expected reference-library organization is documented under:

```text
ref/
```

The standard-cell library used for the project is:

```text
SAED32 RVT
```

The primary operating condition is:

```text
Process:      TT
Voltage:      0.85 V
Temperature:  25 °C
```

The reference environment includes:

- SAED32 RVT NDM
- Liberty/DB standard-cell library
- Milkyway technology data
- TLUPlus parasitic data
- Technology mapping files
- GDS technology data

---

# Proprietary Reference Files

The SAED32 technology libraries and technology files are proprietary and are therefore not included in this repository.

The repository documents the expected directory structure and file paths so that users with legitimate access to the corresponding SAED32 technology files can reproduce the flow.

Expected reference structure:

```text
ref/
├── lib/
│   ├── ndm/
│   │   └── saed32_rvt.ndm/
│   └── stdcell_rvt/
│       ├── saed32rvt_tt0p85v25c.db
│       └── saed32rvt_tt0p85v25c.lib
│
└── tech/
    ├── milkyway/
    │   └── saed32nm_1p9m_mw.tf
    ├── star_rcxt/
    │   ├── saed32nm_1p9m_Cmax.tluplus
    │   ├── saed32nm_1p9m_Cmin.tluplus
    │   └── saed32nm_tf_itf_tluplus.map
    ├── saed32nm_1p9m_gdsout_mw.map
    └── saed32nm_rvt_oa.gds
```

All directory and file paths are case-sensitive and must match the paths referenced by the project TCL scripts and setup files.

---

# Gate-Level Simulation Limitation

Gate-level simulation was not included for the post-synthesis and post-layout stages because the required SAED32 standard-cell functional Verilog simulation models were not available in the accessible project environment.

RTL functional correctness was verified using VCS prior to synthesis.

The synthesized and physical implementations were subsequently evaluated using Synopsys Design Compiler and IC Compiler II reports covering timing, constraints, QoR, routing, congestion, power/ground connectivity, and physical verification.

---

# Software Environment

| Component | Version |
|---|---|
| Operating System | Red Hat Enterprise Linux 8.7 |
| Synopsys VCS | W-2024.09-SP1 |
| Synopsys DVE | W-2024.09-SP1 |
| Synopsys Design Compiler | W-2024.09-SP1 |
| Synopsys Design Vision | W-2024.09-SP1 |
| Synopsys IC Compiler II | W-2024.09-SP1 |
| Technology | SAED32 32 nm |
| Standard-Cell Library | SAED32 RVT |
| Operating Condition | TT, 0.85 V, 25 °C |

---

# Repository Contents

### `vcs/`

Contains the original RTL and SystemVerilog testbench used for pre-synthesis functional verification.

### `dc/`

Contains the Design Compiler source files, constraints, synthesis TCL script, setup file, reports, and generated synthesis results.

### `icc2/`

Contains the IC Compiler II source files, physical-design TCL scripts, setup file, reports, results, and working files.

### `ref/`

Documents the proprietary SAED32 technology and standard-cell library structure required by the flow.

### `images/`

Contains screenshots and visual evidence from the development environment and Synopsys tools.

---

# Reproducibility

To reproduce this project:

1. Use a compatible RHEL environment.
2. Install/access the required Synopsys tools.
3. Obtain legitimate access to the required SAED32 technology libraries.
4. Recreate the documented `ref/` directory structure.
5. Ensure all library paths match the paths referenced in the TCL scripts and setup files.
6. Run RTL functional verification using VCS.
7. Verify the RTL simulation results.
8. Run Design Compiler synthesis.
9. Review the DC reports.
10. Run the ICC2 physical-design flow.
11. Review the ICC2 reports.
12. Inspect the final physical implementation and clock tree.

---

# Project Evidence

Screenshots documenting the project environment and major stages of the flow are available under:

```text
images/screenshots/
```

The documentation includes evidence of:

- RHEL environment
- Synopsys tool versions
- RTL verification
- DVE waveform analysis
- Design Compiler synthesis
- Design Vision
- ICC2 floorplanning
- Power planning
- Placement
- Clock-tree synthesis
- Routing
- Clock-tree analysis
- Final physical implementation

---

# Important Notes

- The SAED32 reference files are proprietary and are intentionally excluded.
- Paths referenced by the TCL scripts are case-sensitive.
- The RTL was functionally verified before synthesis.
- Post-synthesis and post-layout gate-level simulation was not performed because the required SAED32 functional Verilog cell models were unavailable.
- Synthesis and physical implementation were evaluated using Synopsys reports and physical-design analysis.
- `.graph_data.txt` was an empty working/generated file in the original environment.

---

# Author

**Sai Subrahmanya**

M.Tech — VLSI & Embedded Systems
