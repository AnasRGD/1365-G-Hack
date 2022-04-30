provider "google" {
  project     = var.project_id
  region      = "europe-west1"
  credentials = var.gcp_credentials
}

data "google_service_account" "terraform" {
  account_id = "g-hack-terraform"
}

data "google_project" "current_project" {
}

module "file_ingest" {
  source = "./files_ingest"

  bucket_prefix                   = var.bucket_prefix
  gcs_to_bq_version               = var.gcs_to_bq_version
  move_files_version              = var.move_files_version
  task_creator_version            = var.task_creator_version
  terraform_service_account_email = data.google_service_account.terraform.email
  queue_location                  = var.queue_location
}
