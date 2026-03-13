terraform {
  required_providers {
    google = { source = "hashicorp/google"
      version = "7.23.0"
    }
  }
}
provider "google" {
  # credentials = "./keys/Terraform Project 490102.json"
  project = "terrafrom-project-490102"
  region  = "us-central1"
}
# create a google storage bucket
# resource "PROVIDER_RESOURCE" "LOCAL_NAME"
resource "google_storage_bucket" "demo-bucket" {
  name          = "terrafrom-project-490102-terra-bucket" #unique name globally
  location      = "US"
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
