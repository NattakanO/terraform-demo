terraform {
  required_providers {
    google = { source = "hashicorp/google"
      version = "7.23.0"
    }
  }
}
provider "google" {
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}
# create a google storage bucket
# resource "PROVIDER_RESOURCE" "LOCAL_NAME"
resource "google_storage_bucket" "demo-bucket" {
  name          = var.gcs_bucket_name #unique name globally
  location      = var.location
  force_destroy = true

  # automatic storage management rules
  lifecycle_rule {
    condition {
      age = 1 # 1 day after creation
    }
    # Cancel unfinished uploads
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}


resource "google_bigquery_dataset" "demo_dataset" {
  dataset_id = var.bq_dataset_name
  # friendly_name               = "test"
  # description                 = "This is a test description"
  location = var.location
  # default_table_expiration_ms = 3600000

  # labels = {
  #   env = "default"
  # }
}

