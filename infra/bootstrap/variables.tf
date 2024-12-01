variable "ds_semester" {
  type        = string
  description = "Data science semester"
}

variable "user_id" {
  type        = number
  description = "Data science user id"
}
variable "billing_account" {
  type        = string
  description = "Billing account a project is attached to"
}
variable "region" {
  type        = string
  default     = "europe-west1"
  description = "GCP region"
}