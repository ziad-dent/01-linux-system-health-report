# 01 - Linux System Health Report
A Bash script that generates a snapshot report of a Linux system's health — CPU, memory, disk usage, recent system errors, and failed services — and saves it to a timestamped log file.
This is the **first project** in my DevOps Learning Journey, built while studying Linux system administration fundamentals.

## Environment
- **OS:** Ubuntu (via WSL2 on Windows)
- **Shell:** Bash
- **Tools used:** `top`, `free`, `df`, `journalctl`, `systemctl`, `tee`

## What it does
The script collects five categories of system information and prints them to the terminal while simultaneously saving them to a report file:
1. **CPU & Memory usage** — via `top` (batch mode) and `free -h`
2. **Disk usage** — via `df -h`, filtered to real disk partitions
3. **Recent system errors** — last 5 error-level entries from `journalctl`
4. **Failed services** — any systemd service currently in a failed state
5. **Timestamped report file** — saved under `~/health_reports/`

## Usage
```bash
chmod +x system_health_report.sh
./system_health_report.sh
```
Each run creates a new report file named `report_YYYY-MM-DD_HH-MM-SS.txt` inside `~/health_reports/`.

## Example output
See [`sample_output.txt`](./sample_output.txt) for a real run on my WSL2 Ubuntu environment.