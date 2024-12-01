output "project_name" {
  value       = google_project.tbd_project.project_id
  description = "Project identifier"
}
output "terraform_state_bucket" {
  value       = trimprefix(google_storage_bucket.state-bucket.url, "gs://")
  description = "Terraform state bucket"
}

output "terraform_service_account" {
  value       = google_service_account.terraform.email
  description = "Terraform service account"
}