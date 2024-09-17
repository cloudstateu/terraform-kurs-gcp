run "bucket_created" {
    command = apply

    variables {
        project_name = "app"
        environment_name = "prod"
    }

    assert {
        condition = google_storage_bucket.bucket.name == "sto-prod-app"
        error_message = "Invalid bucket name"
    }
}

run "website_live" {
    command = apply 

    module {
        source = "./module/http_test"
    }

    variables {
        endpoint = run.bucket_created.index_url
    }

    assert {
        condition = data.http.index.status_code == 200
        error_message = "Website is no available"
    }
}