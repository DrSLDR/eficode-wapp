variable "GCP_PROJECT" {
  type        = string
  description = "Google Cloud Services Project Name. Should be provided via environment."
}
variable "GCP_REGION" {
  type        = string
  description = "Google Cloud Services Region."
  default     = "us-west1"
}
variable "GCP_ZONE" {
  type        = string
  description = "Google Cloud Services Zone in the Region."
  default     = "us-west1-a"
}
variable "GCP_CE_TYPE" {
  type        = string
  description = "Google Cloud Compute Engine machine type. Note that only e2-micro is 'free' to use."
  default     = "e2-micro"
}
variable "GCP_SSH_KEYS" {
  type        = string
  description = "SSH keys metadata string to be injected into the VM."
  default     = "sldr:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0bTE1x66xFwFS+ctz7pyrTloTW8YQ704shLFmsdsVa"
}
