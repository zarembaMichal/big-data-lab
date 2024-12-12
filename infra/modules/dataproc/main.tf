
resource "google_project_service" "dataproc" {
  provider           = google
  service            = "dataproc.googleapis.com"
  disable_on_destroy = true
}

resource "google_service_account" "default" {
  account_id   = "ds-service-account"
  display_name = "DS Lab Service Account"
}

resource "google_project_iam_member" "dataproc-service-account" {
  for_each = toset([
    "roles/dataproc.worker",
    "roles/storage.admin",
  ])
  project = var.project_name
  role    = each.key
  member  = "serviceAccount:${google_service_account.default.email}"
}


resource "google_dataproc_cluster" "dataproc-cluster" {
  #checkov:skip=CKV_GCP_91: "Ensure Dataproc cluster is encrypted with Customer Supplied Encryption Keys (CSEK)"
  depends_on = [google_project_service.dataproc, google_project_iam_member.dataproc-service-account]
  name       = "ds-cluster"
  project    = var.project_name
  region     = var.region

  cluster_config {
    lifecycle_config {
      idle_delete_ttl = var.idle_delete_ttl
    }

    endpoint_config {
      enable_http_port_access = "true"
    }
    software_config {
      image_version       = var.image_version
      optional_components = ["JUPYTER"]
      override_properties = {
        "dataproc:jupyter.notebook.gcs.dir" : "gs://${var.project_name}-notebook-data/data"
      }
    }
    gce_cluster_config {
      subnetwork       = var.subnet
      internal_ip_only = true
      metadata = {
        "PIP_PACKAGES" = "pandas<2 mlflow==2.18.0 google-cloud-storage==2.18.2"
        "vmDnsSetting" = "GlobalDefault"
      }
      service_account = google_service_account.default.email
      service_account_scopes = [
        "cloud-platform"
      ]
    }
    initialization_action {
      script      = "gs://goog-dataproc-initialization-actions-${var.region}/python/pip-install.sh"
      timeout_sec = "600"
    }

    master_config {
      num_instances = 1
      machine_type  = var.machine_type
      disk_config {
        boot_disk_type    = "pd-standard"
        boot_disk_size_gb = 100
      }
    }

    worker_config {
      num_instances = 2
      machine_type  = var.machine_type
      disk_config {
        boot_disk_type    = "pd-standard"
        boot_disk_size_gb = 100
      }

    }
  }
}