variable "project" {
  description = "project"
  default     = "terrafrom-project-490102"
}

variable "credentials" {
  description = "credentials"
  default     = "./keys/Terraform Project 490102.json"
}

variable "region" {
  description = "region"
  default     = "us-central1"
}
variable "bq_dataset_name" {
  description = "my bigQuery dataset name"
  default     = "demo_dataset"
}

variable "gcs_bucket_name" {
  description = "my Google Cloud Storage bucket name"
  default     = "terrafrom-project-490102-terra-bucket"
}

variable "gcs_storage_class" {
  description = "Bucketstorage class"
  default     = "STANDARD"

}
variable "location" {
  description = "Bucket location"
  default     = "US"
}
