## Make improvement to how the vars are used, to eliminate static values

resource "google_cloudfunctions2_function" "function1" {
  name        = "function1"
  location    = var.region
  description = "A simple hello world Cloud Function"

  build_config {
    runtime     = var.python_runtime
    entry_point = "your_function_name_here"

    source {
      storage_source {
        bucket = var.gcs_bucket
        object = google_storage_bucket_object.function1.name
      }
    }
  }

  service_config {
    max_instance_count = 1
    available_memory   = "256M"
    timeout_seconds    = 60
  }

}

## The goal here is to zip up code which we will need to push to a GCP bucket
data "archive_file" "function1" {
  type        = "zip"
  output_path = "${path.module}/file_name.zip"
  source_dir  = "${path.module}"
}

## Place the zip file in the bucket to be picked up - the zip file defaults to
## The function service root folder as seen in the current configuration 

resource "google_storage_bucket_object" "function1" {
  source       = data.archive_file.function1.output_path
  content_type = "application/zip"

  name         = "src-${data.archive_file.function1.output_md5}.zip"
  bucket       = "your_bucket_name"

}
