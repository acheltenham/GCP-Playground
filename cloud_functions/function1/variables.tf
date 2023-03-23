variable "project_id" {
  type        = string
  description = "The Google Cloud project ID."
}

variable "region" {
  description = "The Google Cloud region."
}

variable "zone" {
  description = "The Google Cloud zone."
}

variable "gcs_bucket" {
  type = string
}

variable "gcs_bucket_prefix" {
  type = string
}


variable "python_runtime" {
  type = string
}
