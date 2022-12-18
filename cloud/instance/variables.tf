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
