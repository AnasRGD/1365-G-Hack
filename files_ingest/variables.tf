variable "bucket_prefix" {
  type    = string
  description = "The prefix of integration bucket names"
}

variable "gcs_to_bq_version" {
  type = string
  description = "The gcs2bq function version to use"

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^v\\d+\\.\\d+\\.\\d+$", var.gcs_to_bq_version))
    error_message = "The gcs_to_bq_version value must be a valid version tag (e.g: v1.0.0)."
  }
}

# variable "move_files_version" {
#   type = string
#   description = "The move files function version to use"

#   validation {
#     # regex(...) fails if it cannot find a match
#     condition     = can(regex("^v\\d+\\.\\d+\\.\\d+$", var.move_files_version))
#     error_message = "The move_files_version value must be a valid version tag (e.g: v1.0.0)."
#   }
# }

# variable "task_creator_version" {
#   type = string
#   description = "The task creator function version to use"

#   validation {
#     # regex(...) fails if it cannot find a match
#     condition     = can(regex("^v\\d+\\.\\d+\\.\\d+$", var.task_creator_version))
#     error_message = "The task_creator_version value must be a valid version tag (e.g: v1.0.0)."
#   }
# }

variable "function_region" {
  type = string
  description = "Where to deploy the functions"
  default = "europe-west1"
}

variable "queue_location" {
  type = string
  description = "Where the Cloud task queues should be deployed"
  default = "europe-west1"
}


# variable "bucket_function_registry" {
#   type = string
#   description = "The bucket where to find functions zip files"
#   default = "devo-hack-functions-registry"
# }

variable "terraform_service_account_email" {
  type = string
  description = "The email of the service account used by terraform"
}
