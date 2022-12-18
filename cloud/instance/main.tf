# Fundamental Terraform configuration
terraform {
  backend "local" {
    path = "instance.tfstate"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.46.0"
    }
  }
}

# Define the Google provider
provider "google" {
  credentials = file("../key.json")

  project = var.GCS_PROJECT
  region  = var.GCS_REGION
  zone    = var.GCS_ZONE
}
