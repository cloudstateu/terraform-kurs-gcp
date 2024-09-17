provider "google" {
    region = "europe-west1"
}

variables {
    project_name = "app"
}

run "valid_bucket_name" {
    command = plan

    variables {
        environment_name = "prod"
    }

    assert {
        condition = google_storage_bucket.bucket.name == "sto-prod-app"
        error_message = "Invalid bucket name"
    }
}

run "invalid_environment" {
    command = plan

    variables {
        environment_name = "uat"
    }

    expect_failures = [
        var.environment_name
    ]
}