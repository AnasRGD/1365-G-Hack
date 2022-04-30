########################## GCS ########################
# Create gcs_to_bq dedicated service account
resource "google_service_account" "gcs-to-bq" {
  account_id   = "gcs-to-bq"
  display_name = "Service Account to run gcs_to_bq cloud function"
}

resource "google_project_iam_custom_role" "gcs_to_bq_role" {
  role_id     = "gcs_to_bq_function"
  title       = "GCS to BigQuery function customized role"
  description = "A customized IAM role for gcs to bq function"
  permissions = [
    "storage.objects.get", 
    "storage.objects.list",
    "bigquery.jobs.create", 
    "bigquery.jobs.get", 
    "bigquery.jobs.update", 
    "bigquery.jobs.delete",
    "bigquery.tables.create", 
    "bigquery.tables.get", 
    "bigquery.tables.getData",
    "bigquery.tables.update",
    "bigquery.tables.updateData"
  ]
}

# Grant gcs-to-bq service account adequate roles
resource "google_project_iam_member" "gcs_to_bq_permissions" {
  project = data.google_project.current_project.project_id
  role = google_project_iam_custom_role.gcs_to_bq_role.id
  member  = "serviceAccount:${google_service_account.gcs-to-bq.email}"
}

resource "google_pubsub_topic_iam_binding" "gcs_to_bq_function_pubsub_publisher" {
  project = data.google_project.current_project.project_id
  topic = google_pubsub_topic.gcs_to_bq_integration_done.name
  role = "roles/pubsub.publisher"
  members = [
    "serviceAccount:${google_service_account.gcs-to-bq.email}",
  ]
}

resource "google_service_account_iam_member" "gcs_to_bq_sa_user" {
  service_account_id = google_service_account.gcs-to-bq.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${var.terraform_service_account_email}"
}


########################## move_files ########################
# Create move-files and delete-files dedicated service accounts
resource "google_service_account" "move_delete_files" {
  account_id   = "move-delete-files"
  display_name = "Service Account to run move_files and delete_files cloud function"
}

resource "google_project_iam_custom_role" "move_files_role" {
  role_id     = "move_files_function"
  title       = "Move files function dedicated role"
  description = "A customized IAM role for move files function"
  permissions = [
    "storage.objects.create",
    "storage.objects.delete",
    "storage.objects.get"
  ]
}


# Grant move-files and delete-files service account adequate roles
resource "google_project_iam_member" "move_delete_files_function_gcs_editor" {
  project = data.google_project.current_project.project_id
  role    = google_project_iam_custom_role.move_files_role.id
  member  = "serviceAccount:${google_service_account.move_delete_files.email}"
}


resource "google_service_account_iam_member" "move_delete_files_sa_user" {
  service_account_id = google_service_account.move_delete_files.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${var.terraform_service_account_email}"
}

########################## task_creator ########################

# Create move-files and delete-files dedicated service accounts
resource "google_service_account" "task_creator" {
  account_id   = "task-creator"
  display_name = "Service Account to run task_creator and task_creator_done cloud function"
}

resource "google_project_iam_custom_role" "task_creator_role" {
  role_id     = "task_creator_function"
  title       = "Task creator function dedicated role"
  description = "A customized IAM role for task creator function"
  permissions = [
    "storage.buckets.get",
    "storage.objects.get",
    "cloudtasks.tasks.create", 
    "iam.serviceAccounts.actAs", 
    "cloudfunctions.functions.invoke"
    ]
}

# Grant task_creator and task_creator_done service account adequate roles
resource "google_project_iam_member" "task_creator_permissions" {
  project = data.google_project.current_project.project_id
  #role    = google_project_iam_custom_role.task_creator_role.id
  role = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.task_creator.email}"
}




resource "google_service_account_iam_member" "task_creator_sa_user" {
  service_account_id = google_service_account.task_creator.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${var.terraform_service_account_email}"
}