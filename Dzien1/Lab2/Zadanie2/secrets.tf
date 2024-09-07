resource "google_secret_manager_secret" "student0" {
  secret_id = "secret"
  project   = data.google_project.student00.project_id

  replication {
    auto {}
  }
}