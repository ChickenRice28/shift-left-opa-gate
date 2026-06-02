package main

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_s3_bucket_acl"
  resource.change.after.acl != "private"
  msg := sprintf(
    "VIOLATION: %s [%s] has ACL set to '%s'. Remediation: set acl = \"private\".",
    [resource.address, resource.type, resource.change.after.acl]
  )
}
