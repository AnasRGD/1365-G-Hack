resource "google_service_account" "dataflow_sa" {
  account_id   = "relex-gtw-dataflow-sa"
  display_name = "Service Account to run dataflow jobs"
}

resource "google_project_iam_member" "dataflow_sa_bigquery_editor" {
  project = data.google_project.current_project.project_id
  role    = "roles/bigquery.dataEditor"
  member  = "serviceAccount:${google_service_account.dataflow_sa.email}"
}

resource "google_pubsub_topic_iam_binding" "dataflow_sa_pubsub_subscriber" {
  project = data.google_project.current_project.project_id
  
  for_each = { for dataflow_job in var.dataflow_jobs : dataflow_job.topic => dataflow_job}
  topic = each.value.topic
  role = "roles/pubsub.subscriber"
  members = [
    "serviceAccount:${google_service_account.dataflow_sa.email}",
  ]
}

resource "google_storage_bucket_iam_binding" "dataflow_sa_gcs_admin" {
  bucket = "${var.bucket_prefix}-${var.dataflow_bucket}"
  role = "roles/storage.objectAdmin"
  members = [
    "serviceAccount:${google_service_account.dataflow_sa.email}",
  ]
}