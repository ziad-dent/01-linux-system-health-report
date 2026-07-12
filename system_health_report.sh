#!/bin/bash
# System Health Report
# Author: Ziad Elmelegy
# Description: Collects CPU, RAM, Disk, Logs, and  Service status into one readable repirt.


# 1. Setup: report file with today:s date
REPORT_DIR="$HOME/heath_reports"
mkdir -p "$REPORT_DIR"
REPORT_FILE="$REPORT_DIR/report_$(date +%Y-%m-%d-%H-%M-%S).txt"

log() {
    echo "$1" | tee -a "$REPORT_FILE"
}
log "========================================="
log " System Health Report "
log " Generated: $(date) "
log " Hostname:  $(hostname) "
log "========================================="
log ""

# 2. CPU & Memory usage
log "-------------------------------- CPU & Memory --------------------------------"
log " $(top -bn1 | grep "Cpu(s)")"
log ""
log "$(free -h)"
log ""

# 3. Dosk space
log "---------------------------------- Disk Usage ----------------------------------"
log "$(df -h --output=source,size,used,avail,pcent,target | grep -E '^/dev/')"
log ""

# 4. Recent errors from system logs
log "----------------------------- Last 5 System Errors -----------------------------"
ERRORS=$(journalctl -p err -n 5 --no-pager 2>/dev/null)
if [ -z "$ERRORS" ]; then
    log "No recent errors found (or journalctl not available)."
else
    log "$ERRORS"
fi
log ""

# 5. Failed services
log "-------------------------------- Failed Services --------------------------------"
FAILED=$(systemctl --failed --no-legend 2>/dev/null)
if [ -z "$FAILED" ]; then
    log "No failed services. All good."
else
    log "$FAILED"
fi
log ""