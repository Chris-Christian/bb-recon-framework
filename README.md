# bb-recon-framework

A semi-automated reconnaissance and attack-surface mapping framework designed for **bug bounty hunters and penetration testers**.
The framework focuses on **structured recon, intelligent prioritization, and manual testing guidance**.

---

## Overview

**bb-recon-framework** automates the reconnaissance workflow while keeping vulnerability discovery logic-driven and human-focused.
It collects, organizes, analyzes, and summarizes attack surface data into a clean, actionable format.

---

## Features

* Target initialization with structured workspace
* Subdomain enumeration
* Live host detection
* Endpoint discovery and parameter extraction
* Attack surface categorization (auth, api, upload, redirect, admin)
* Automated **manual testing checklist**
* Automated **vulnerability hypotheses**
* Order-independent **recon summary report**
* Idempotent execution (safe to rerun)
* Master controller (`run_all.sh`) for one-command recon

---

## Installation

Clone the repository and prepare the scripts:

```bash
git clone https://github.com/Chris-Christian/bb-recon-framework.git
cd bb-recon-framework
chmod +x run_all.sh
chmod +x scripts/*.sh
```

---

## Usage

Run the full recon pipeline:

```bash
./run_all.sh example.com
```

The framework will automatically:

1. Initialize target workspace
2. Enumerate subdomains
3. Detect live hosts
4. Discover endpoints & parameters
5. Categorize attack surface
6. Generate manual testing checklist
7. Generate vulnerability hypotheses
8. Produce final recon summary report

---

## Project Structure

```
bb-recon-framework/
│
├── scripts/                # Core workflow scripts
├── targets/                # Per-target workspace
│   └── example.com/
│       ├── recon/
│       ├── endpoints/
│       ├── notes/
│       └── report.md
│
├── run_all.sh              # Master controller
└── README.md
```

---

## Output

For each target, the framework generates:

* Recon data (subdomains, live hosts, endpoints)
* Categorized attack surface
* `manual_testing.md` → structured testing checklist
* `hypotheses.md` → predicted vulnerability classes
* `report.md` → full recon summary

---

## Requirements

Ensure the following tools are installed:

* subfinder
* httpx (ProjectDiscovery version)
* gau

---

## Disclaimer

This tool is intended for **educational and authorized security testing only**.
Use only on systems you own or have explicit permission to test.

---

## Author

Chris Christian
Cybersecurity | Bug Bounty | Penetration Testing

---