package main

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_db_instance"
  not resource.change.after.storage_encrypted
  msg := sprintf(
    "VIOLATION: %s [%s] has storage_encrypted = false. Remediation: set storage_encrypted = true.",
    [resource.address, resource.type]
  )
}
