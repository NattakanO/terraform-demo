# Terraform GCP Infrastructure Setup

This project uses **Terraform** to provision the cloud infrastructure
required for the data pipelines.

Terraform is used to create and manage Google Cloud resources such as:

- **Google Cloud Storage bucket (Data Lake)**
- **BigQuery dataset (Data Warehouse)**

Using **Infrastructure as Code (IaC)** ensures that the environment is
reproducible, version-controlled, and easy to manage.

---

# Terraform Configuration

The Terraform configuration performs the following tasks:

1.  Configure the **Google Cloud provider**
2.  Create a **Google Cloud Storage bucket**
3.  Create a **BigQuery dataset**

---

# Provider Configuration

Terraform uses the Google Cloud provider to manage resources.

```hcl
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.23.0"
    }
  }
}
```

---

# Google Cloud Provider

```hcl
provider "google" {
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}
```

Parameter Description

- credentials -> Path to the Google Cloud service account JSON
- project -> Google Cloud project ID
- region -> Default region for resources

---

# Google Cloud Storage Bucket

The following resource creates a **GCS bucket**, which acts as the
**data lake** for storing raw datasets.

```hcl
resource "google_storage_bucket" "demo-bucket" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true
}
```

Parameter Description

- name -> Globally unique bucket name
- location -> Storage location
- force_destroy -> Allows bucket deletion even if it contains objects

---

# Storage Lifecycle Rule

```hcl
lifecycle_rule {
  condition {
    age = 1
  }

  action {
    type = "AbortIncompleteMultipartUpload"
  }
}
```

This rule cancels incomplete multipart uploads older than **1 day**.

---

# BigQuery Dataset

Terraform also creates a dataset in BigQuery.

```hcl
resource "google_bigquery_dataset" "demo_dataset" {
  dataset_id = var.bq_dataset_name
  location   = var.location
}
```

Parameter Description

- dataset_id -> Name of the BigQuery dataset
- location -> Dataset location

---

# Example terraform.tfvars

```hcl
project         = "your-project-id"
region          = "europe-west2"
location        = "EU"
gcs_bucket_name = "your-unique-bucket-name"
bq_dataset_name = "zoomcamp"
credentials     = "path/to/service-account.json"
```

---

# Deployment Steps

Initialize Terraform:

```bash
terraform init
```

Preview infrastructure changes:

```bash
terraform plan
```

Apply the configuration:

```bash
terraform apply
```

Terraform will create:

- Google Cloud Storage bucket
- BigQuery dataset

---

# Technologies Used

- Terraform
- Google Cloud Platform
- Google Cloud Storage
- BigQuery
