provider "google" {
  project = var.project_id
  region  = "asia-northeast1"
  credentials = file(var.credentials_file)
}

terraform {
  backend "gcs" {
    bucket = "valiant-song-420805-tfstate"
    prefix = "terraform/state"
  }
}

resource "google_cloud_run_service" "default" {
  name     = "hello-cloud-run"
  location = "asia-northeast1"

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "bucket_name" {
  description = "The name of the GCS bucket for storing Terraform state"
  type        = string
}

variable "credentials_file" {
  description = "The path to the GCP credentials file"
  type        = string
}