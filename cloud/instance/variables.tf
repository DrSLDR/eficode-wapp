variable "GCS_PROJECT" {
  type        = string
  description = "Google Cloud Services Project Name. Should be provided via environment."
}
variable "GCS_REGION" {
  type        = string
  description = "Google Cloud Services Region."
  default     = "us-west1"
}
variable "GCS_ZONE" {
  type        = string
  description = "Google Cloud Services Zone in the Region."
  default     = "us-west1-a"
}
variable "GCS_SSH_KEYS" {
  type        = string
  description = "SSH keys metadata string to be injected into the VM."
  default     = "sldr:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0bTE1x66xFwFS+ctz7pyrTloTW8YQ704shLFmsdsVa"
}
