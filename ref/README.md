# Reference Technology and Library Files

This directory documents the proprietary SAED32 technology and standard-cell library structure required by the RTL-to-GDS flow.

## Important

The actual SAED32 technology and standard-cell library files are proprietary and are therefore **not included in this repository**.

Users must have legitimate access to the corresponding technology files before attempting to reproduce the flow.

---

# Expected Directory Structure

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

---

# Library

The project uses the SAED32 RVT standard-cell library.

The primary operating condition is:

```text
Process      = TT
Voltage      = 0.85 V
Temperature  = 25 °C
```

---

# Path Requirements

The directory and file names are case-sensitive.

The reference files must be placed at the paths expected by the Design Compiler and IC Compiler II setup files and TCL scripts.

Incorrect capitalization or directory names may cause library-loading or file-resolution errors.

---

# Licensing

The SAED32 technology and library files are not redistributed through this repository.

They must be obtained and used according to the applicable licensing and access requirements.
