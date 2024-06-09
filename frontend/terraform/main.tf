provider "google" {
  project     = "mytest-425707"
  region      = "us-central1"
  zone        = "us-central1-a"
  credentials = file(var.credentials_file)
}

resource "google_cloud_run_service" "frontend" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        image = var.container_image
        ports {
          container_port = 3000
        }

        resources {
          limits = {
            memory = "256Mi"
            cpu    = "1000m"
          }
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "invoker" {
  location    = google_cloud_run_service.frontend.location
  project     = google_cloud_run_service.frontend.project
  service     = google_cloud_run_service.frontend.name
  role        = "roles/run.invoker"
  member      = "allUsers" # Change this to limit access if needed
}

variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
  default     = "mytest-425707"
}

variable "region" {
  description = "The region in which to create the Cloud Run service."
  type        = string
  default     = "us-central1"
}

variable "service_name" {
  description = "The name of the Cloud Run service."
  type        = string
  default     = "frontend"
}

variable "container_image" {
  description = "The URL of the container image in a container registry."
  type        = string
  default     = "us-central1-docker.pkg.dev/mytest-425707/frontend/frontend:latest"
}

variable "credentials_file" {
  description = "The path to the service account key file."
  type        = string
  default     = "~/terraform-key.json"
}