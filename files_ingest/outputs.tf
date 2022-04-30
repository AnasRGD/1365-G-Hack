output "gcs_to_bq_topic_name" {
  value = google_pubsub_topic.gcs_to_bq_integration_done.name
}

output "integration_bucket_names" {
  value = local.integration_bucket_names
}

output "bucket_with_notifications" {
  value = local.buckets_with_notification
}
