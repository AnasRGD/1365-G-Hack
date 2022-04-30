variable "project_id" {
  description = "The project id of the GCP project"
  type = string
}

variable "bucket_function_registry" {
  description = "The bucket where the function are stored"
  type = string
}

variable "bucket_prefix" {
  description = "The prefix given to the ingest buckets"
  type = string
}

variable "gcs_to_bq_version" {
  description = "The version of gcs 2 bq function bq to deploy"
  type = string
}

variable "task_creator_version" {
  description = "The version of task creator function to deploy"
  type = string
}

variable "move_files_version" {
  description = "The version of move files function to deploy"
  type = string
}

variable "key_rotator_version" {
  description = "The version of key rotator function to deploy"
  type = string
}

variable "monitoring_file_function_version" {
  description = "The version of monitoring files function to deploy"
  type = string
}

variable "max_ingest_time" {
  description = "The maximum of time supposed (in minutes) for monitoring"
  type = number
}

variable "workplace_notifier_function_version" {
  description = "The version of the workplace notifier function to deploy"
  type = string
}

variable "workplace_thread_key" {
  description = "The identifier of the workplace thread to publish"
  type = string
}

variable "bucket_transfile_in_name" {
  description = "The name of the bucket for transfiles in"
  type = string
  default = ""
}

variable "queue_location" {
  description = "The GCP region of Cloud Task queues"
  type = string
}

variable "work_bucket_composer_name" {
  type = string
  description = "The name of Airflow work bucket"
}

variable "backup_bucket_composer_name" {
  type = string
  description = "The name of Airflow backup bucket"
}

variable "tf_workspace_id" {
  description = "Terraform workspace ID"
  type = string
}

variable "gzip_function_version" {
  description = "Version to use for gzip in Cloud Run"
  type = string
}

variable "gcp_credentials" {
  type = string
  sensitive = true
  description = "Google Cloud service account credentials"
}