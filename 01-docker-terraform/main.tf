terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
# Credentials only needs to be set if you do not have the GOOGLE_APPLICATION_CREDENTIALS set
#  credentials = 
  project = "data-engineering-2024-411821"
  region  = "us-east4"
}



resource "google_storage_bucket" "data-lake-bucket" {
  name          = "data-engineering-2024-411821-bucket"
  location      = "US"

  # Optional, but recommended settings:
  storage_class = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled     = true
  }

  force_destroy = true
}


# resource "google_bigquery_dataset" "dataset" {
#   dataset_id = "<The Dataset Name You Want to Use>"
#   project    = "<Your Project ID>"
#   location   = "US"
# }

# terraform {
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = "5.6.0"
#     }
#   }
# }

# provider "google" {
#   credentials = file(var.credentials)
#   project     = var.project
#   region      = var.region
# }


# resource "google_storage_bucket" "demo-bucket" {
#   name          = var.gcs_bucket_name
#   location      = var.location
#   force_destroy = true


#   lifecycle_rule {
#     condition {
#       age = 1
#     }
#     action {
#       type = "AbortIncompleteMultipartUpload"
#     }
#   }
# }



# resource "google_bigquery_dataset" "demo_dataset" {
#   dataset_id = var.bq_dataset_name
#   location   = var.location
# }