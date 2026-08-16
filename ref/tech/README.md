# SAED32 Technology Files

This directory documents the technology, routing, parasitic, and physical-design files required by the ICC2 flow.

## Expected Structure

```text
tech/
├── milkyway/
│   └── saed32nm_1p9m_mw.tf
│
├── star_rcxt/
│   ├── saed32nm_1p9m_Cmax.tluplus
│   ├── saed32nm_1p9m_Cmin.tluplus
│   └── saed32nm_tf_itf_tluplus.map
│
├── saed32nm_1p9m_gdsout_mw.map
└── saed32nm_rvt_oa.gds
```

## Purpose

These files provide the technology and parasitic information required for physical implementation and extraction.

The project uses the SAED32 32 nm technology with a 1P9M metal configuration.

## Proprietary Files

The actual technology files are proprietary and are not included in this repository.

Users reproducing the project must have legitimate access to the corresponding SAED32 technology files.
