provider "google" {
  project     = var.project_id
  region      = "europe-west1"
  credentials = var.gcp_credentials
}

data "google_service_account" "terraform" {
  account_id = "g-hack-terraform-g-hack-348808"
}

data "google_project" "current_project" {
}

module "file_ingest" {
  source = "./files_ingest"

  bucket_prefix                   = var.bucket_prefix
  terraform_service_account_email = data.google_service_account.terraform.email
}

module "streaming_ingest" {
  source = "./streaming_ingest"
  bucket_prefix                   = var.bucket_prefix
}