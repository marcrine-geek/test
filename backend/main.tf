provider "google" {
  project = "backend"
}
# Deploy image to Cloud Run
resource "google_cloud_run_service" "backend" {
  name     = "backend"
  location = "us-central1"
  template {
    spec {
      containers {
        image = "gcr.io/backend/backend"
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}
# Create public access
data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}
# Enable public access on Cloud Run service
resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.backend.location
  project     = google_cloud_run_service.backend.project
  service     = google_cloud_run_service.backend.name
  policy_data = data.google_iam_policy.noauth.policy_data
}
# Return service URL
output "url" {
  value = "${google_cloud_run_service.backend.status[0].url}"
}
