variable "project_id" {
  description = "The project id of the GCP project"
  type = string
}

# variable "bucket_function_registry" {
#   description = "The bucket where the function are stored"
#   type = string
# }

variable "bucket_prefix" {
  description = "The prefix given to the ingest buckets"
  type = string
}

# variable "gcs_to_bq_version" {
#   description = "The version of gcs 2 bq function bq to deploy"
#   type = string
# }

# variable "task_creator_version" {
#   description = "The version of task creator function to deploy"
#   type = string
# }

# variable "move_files_version" {
#   description = "The version of move files function to deploy"
#   type = string
# }


# variable "monitoring_file_function_version" {
#   description = "The version of monitoring files function to deploy"
#   type = string
# }

# variable "max_ingest_time" {
#   description = "The maximum of time supposed (in minutes) for monitoring"
#   type = number
# }


# variable "queue_location" {
#   description = "The GCP region of Cloud Task queues"
#   type = string
# }


variable "gcp_credentials" {
  type = string
  sensitive = true
  description = "Google Cloud service account credentials"
}