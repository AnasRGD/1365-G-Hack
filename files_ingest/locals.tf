locals {
  integration_bucket_names = [for suffix in ["configuration","backup", "error-backup", "work"]: "${var.bucket_prefix}-${suffix}"]
  buckets_with_notification = slice(local.integration_bucket_names, 2, length(local.integration_bucket_names) )
}