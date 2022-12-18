variable "GCS_PROJECT" {
  type        = string
  description = "Google Cloud Services Project Name. Should be provided via environment."
}
variable "GCS_REGION" {
  type        = string
  description = "Google Cloud Services Region. Can be provided via environment."
  default     = "us-west1"
}
