resource "google_cloud_tasks_queue" "gcs2bq-work" {
  name = "gcs2bq-work"
  location = var.queue_location

  rate_limits {
    max_dispatches_per_second = 0.4
  }

  retry_config {
    max_attempts = 3
    min_backoff = "20s"
  }

  stackdriver_logging_config {
    sampling_ratio = 1.0
  }
}

resource "google_cloud_tasks_queue" "gcs2bq-from-error" {
  name = "gcs2bq-from-error"
  location = var.queue_location

  rate_limits {
    max_dispatches_per_second = 0.1
  }

  retry_config {
    max_attempts = 3
    min_backoff = "30s"
  }

  stackdriver_logging_config {
    sampling_ratio = 1.0
  }
}

resource "google_cloud_tasks_queue" "move-files" {
  name = "move-files"
  location = var.queue_location

  retry_config {
    max_attempts = 3
    min_backoff = "40s"
  }

  stackdriver_logging_config {
    sampling_ratio = 1.0
  }
}