# SAED32 Standard-Cell Library

This directory represents the standard-cell library portion of the SAED32 technology environment.

## Expected Structure

```text
lib/
├── ndm/
│   └── saed32_rvt.ndm/
│
└── stdcell_rvt/
    ├── saed32rvt_tt0p85v25c.db
    └── saed32rvt_tt0p85v25c.lib
```

## Library Configuration

The project uses the SAED32 RVT library at the typical operating condition:

```text
Process      = TT
Voltage      = 0.85 V
Temperature  = 25 °C
```

The NDM library is used by IC Compiler II, while the Liberty/DB files are used during synthesis and library characterization.

The actual library files are proprietary and are intentionally excluded from this repository.
