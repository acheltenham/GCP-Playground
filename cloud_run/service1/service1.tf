resource "google_project_service" "cloud_run" {
  service = "run.googleapis.com"
}

resource "google_cloud_run_v2_job" "service1" {
  name     = "service1"
  location = var.region
  launch_stage = "BETA"

  template {
    template {
      containers {
        image = "gcr.io/[PROJECT]/[BUILD_NAME]:latest"
      }
    }
  }
  
  depends_on = [
    google_project_service.cloud_run
  ]
}