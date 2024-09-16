resource "random_password" "db_password" {
  length      = 15
  special     = true
  min_numeric = 5
}

resource "google_sql_database_instance" "student0" {
  name             = "db-${local.prefix}"
  database_version = "POSTGRES_15"

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_user" "student0" {
  name     = "user-${local.prefix}"
  instance = google_sql_database_instance.student0.name
  password = random_password.db_password.result
}
