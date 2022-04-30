variable "bucket_prefix" {
  type    = string
  description = "The prefix of integration bucket names"
}

variable "dataflow_bucket" {
  type    = string
  description = "Dataflow GCS bucket name"
  default = "gs://devo-hack-dataflow"
}

variable "dataflow_region" {
  type = string
  description = "Where to deploy the Dataflow"
  default = "europe-west1"
}


variable "dataflow_jobs" {
  type = list(object({
    topic = string
    dataset = string
    table = string
  }))
  default = [
    {
      topic = "TOPIC1"
      dataset = "DATASET1"
      table = "TABLE1"
    },
    {
      topic = "TOPIC2"
      dataset = "DATASET2"
      table = "TABLE2"
    }
  ]
}