output "s3_bucket_id" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.example.id
}

output "rds_endpoint" {
  description = "The RDS instance endpoint"
  value       = aws_db_instance.main.endpoint
  sensitive   = true
}
