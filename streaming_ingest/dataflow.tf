resource "google_storage_bucket" "dataflow_bucket" {
  name          = var.dataflow_bucket
  location      = "EU"

  uniform_bucket_level_access = true
}

resource "google_pubsub_topic" "dataflow_jobs_topics" {
  for_each = { for dataflow_job in var.dataflow_jobs : dataflow_job.topic => dataflow_job}
  name = each.value.topic
}
resource "google_bigquery_dataset" "default" {
  project                     = data.google_project.current_project.project_id
  for_each = { for dataflow_job in var.dataflow_jobs : dataflow_job.topic => dataflow_job}

  dataset_id                  = each.value.dataset
  description                 = "This is the BQ dataset for running the dataflow job"
  location                    = "EU"
}

resource "google_dataflow_job" "dataflow_job" {
  project               = data.google_project.current_project.project_id
  region                = var.dataflow_region

  for_each = { for dataflow_job in var.dataflow_jobs : dataflow_job.topic => dataflow_job}

  name                  = "${each.value.topic}_to_bigquery"
  on_delete             = "cancel"
  max_workers           = "3"
  template_gcs_path     = "gs://dataflow-templates/latest/PubSub_Subscription_to_BigQuery"
  temp_gcs_location     = "gs://${var.dataflow_bucket}/${each.value.topic}"
  service_account_email = google_service_account.dataflow_sa.email
  parameters = {
    inputSubscription       = "projects/${data.google_project.current_project.project_id}/subscriptions/SUBSCRIBER-FOR-${each.value.topic}-TOBQ"
    outputTableSpec      = "${data.google_project.current_project.project_id}:${each.value.dataset}.${each.value.table}"
  }
  machine_type     = "n1-standard-1"

  depends_on = [google_pubsub_topic_iam_binding.dataflow_sa_pubsub_subscriber]
}