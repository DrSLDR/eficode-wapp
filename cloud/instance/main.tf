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
  machine_type = var.GCP_CE_TYPE

  tags = ["test", "dev", "web"]

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

# Add a firewall rule to reduce suffering
resource "google_compute_firewall" "rules" {
  name        = "web-permissions"
  network     = "default"
  description = "Allows web traffic to web servers"

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080", "1000-2000"]
  }
  target_tags = ["web"]
}
