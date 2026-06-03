terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.82.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.aws_region
}

# ---- S3 BUCKET (intentionally non-compliant) ----
resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  tags = {
    Environment = "demo"
    Project     = "shift-left-opa-gate"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.example.id
  acl    = "private"   # <-- VIOLATION: triggers s3 deny rule
}

# ---- RDS INSTANCE (intentionally non-compliant) ----
resource "aws_db_instance" "main" {
  identifier        = var.db_identifier
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  username          = var.db_username
  password          = var.db_password
  storage_encrypted = true   # <-- VIOLATION: triggers rds deny rule
  skip_final_snapshot = true

  tags = {
    Environment = "demo"
    Project     = "shift-left-opa-gate"
  }
}
# triggered CI
# retrigger
# retrigger
