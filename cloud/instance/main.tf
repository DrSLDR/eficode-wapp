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

  project = var.GCP_PROJECT
  region  = var.GCP_REGION
  zone    = var.GCP_ZONE
}

# Create our Compute instance
resource "google_compute_instance" "default" {
  name         = "test-instance"
  machine_type = "e2-micro" # Within the Free tier

  tags = ["test", "dev"]

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      network_tier = "PREMIUM"
    }
  }

  metadata = {
    ssh-keys = var.GCP_SSH_KEYS
  }
}
