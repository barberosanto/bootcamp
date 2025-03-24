resource "google_project_service" "compute_api" {
  project                      = var.gcp_project
  service                      = "compute.googleapis.com"
  disable_dependent_services   = false

  lifecycle {
    prevent_destroy = true
  }

}

resource "google_project_service" "container_api" {
  project                      = var.gcp_project
  service                      = "container.googleapis.com"
  disable_dependent_services   = false
  depends_on                   = [google_project_service.compute_api]
}

resource "google_project_service" "iam_api" {
  project                      = var.gcp_project
  service                      = "iam.googleapis.com"
  disable_dependent_services   = false
  depends_on                   = [google_project_service.compute_api]
}

resource "google_project_service" "alloy_api" {
  project                      = var.gcp_project
  service                      = "alloydb.googleapis.com"
  disable_dependent_services   = false
  depends_on                   = [google_project_service.compute_api, google_project_service.iam_api]
}

resource "google_project_service" "servicenetworking_api" {
  project                      = var.gcp_project
  service                      = "servicenetworking.googleapis.com"
  disable_dependent_services   = false
  depends_on                   = [google_project_service.compute_api, google_project_service.alloy_api]
}
