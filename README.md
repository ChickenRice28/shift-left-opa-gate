# Shift-Left Infrastructure Governance
## Automated Multi-Region Policy-as-Code Gate

> Terraform · Open Policy Agent (OPA) · Conftest

Pre-deployment compliance enforcement for AWS infrastructure. Every Terraform configuration is evaluated against organizational security baselines **before** any cloud API call is issued — blocking non-compliant resources at the plan stage, not after.

## How It Works

1. Developer writes Terraform config (`main.tf`)
2. `terraform plan` compiles the config into `plan.json`
3. `conftest test` runs Rego policies against `plan.json`
4. Gate **blocks** deployment if any violation is found
5. `terraform apply` only runs on a clean PASS

## Quick Start

\`\`\`bash
terraform init
terraform plan -out=tfplan.binary
terraform show -json tfplan.binary > plan.json
conftest test plan.json --policy ./policy/
\`\`\`

## Policy Scenarios

| Resource | Violation | Framework |
|---|---|---|
| S3 Bucket | `acl = "public-read"` | SOC 2 CC6.1 · ISO 27001 A.8.3 |
| RDS Instance | `storage_encrypted = false` | SOC 2 CC6.1 · ISO 27001 A.10.1 |

## Project Structure

\`\`\`
shift-left-opa-gate/
├── main.tf
├── variables.tf
├── outputs.tf
├── policy/
│   ├── s3.rego
│   └── rds.rego
└── scripts/
    └── run_checks.sh
\`\`\`
