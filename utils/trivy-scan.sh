#!/bin/bash
set -e

REPORT_PATH=${1:-trivy-report.txt}
TARGET_DIR=${2:-.}

echo "Running Trivy scan on Terraform files in $TARGET_DIR" > "$REPORT_PATH"
find "$TARGET_DIR" -name "*.tf" | while read -r tf_file; do
    echo "Scanning $tf_file" >> "$REPORT_PATH"
    trivy config --scanners misconfig --severity HIGH,CRITICAL "$tf_file" >> "$REPORT_PATH"
done 