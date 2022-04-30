resource "google_storage_bucket" "integration_bucket" {
  for_each = toset(local.integration_bucket_names)

  name          = each.value
  location      = "EU"

}

resource "google_pubsub_topic" "integration-bucket" {
  name = "integration-bucket"   
}

// Enable notifications by giving the correct IAM permission to the unique service account.
data "google_storage_project_service_account" "gcs_account" {
}

resource "google_pubsub_topic_iam_binding" "ingest_notification" {
  topic   = google_pubsub_topic.integration-bucket.id
  role    = "roles/pubsub.publisher"
  members = ["serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"]
}

resource "google_storage_notification" "object_finalize_integration" {
  for_each = toset(local.buckets_with_notification)

  bucket         = each.value
  payload_format = "JSON_API_V1"
  topic          = google_pubsub_topic.integration-bucket.id
  event_types    = ["OBJECT_FINALIZE"]
  depends_on = [
    google_pubsub_topic_iam_binding.ingest_notification,
    google_storage_bucket.integration_bucket
  ]
}