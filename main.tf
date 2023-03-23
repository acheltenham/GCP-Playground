terraform {
  backend "gcs" {
    bucket = "your_bucker_here" #vars are cleaner
    prefix = "folder_here"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.34.0"
    }
    archive = {
      source = "hashicorp/archive"
      version = "2.3.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

## Each service is loaded as a module and we can passed shared vars

module "function1" {
  source = "./cloud_functions/function1"

  project_id        = var.project_id
  region            = var.region
  zone              = var.zone
  gcs_bucket        = var.gcs_bucket
  gcs_bucket_prefix = var.gcs_bucket_prefix
  python_runtime    = var.python_runtime

}

module "service1" {
  source = "./cloud_run/service1"

  project_id = var.project_id
  region     = var.region
  # Pass any other required variables for the service1 module
  zone              = var.zone
  gcs_bucket        = var.gcs_bucket
  gcs_bucket_prefix = var.gcs_bucket_prefix
  python_runtime    = var.python_runtime
}

