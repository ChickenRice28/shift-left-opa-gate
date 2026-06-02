#!/bin/bash
set -e

echo "========================================"
echo " Shift-Left OPA Policy Gate"
echo "========================================"

echo ""
echo "[1/3] Generating Terraform plan..."
terraform plan -out=tfplan.binary

echo ""
echo "[2/3] Serializing plan to JSON..."
terraform show -json tfplan.binary > plan.json

echo ""
echo "[3/3] Running Conftest policy evaluation..."
conftest test plan.json --policy ./policy/

echo ""
echo "========================================"
echo " Gate PASSED. Safe to apply."
echo "========================================"
