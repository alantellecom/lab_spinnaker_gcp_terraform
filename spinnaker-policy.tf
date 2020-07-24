data "google_iam_policy" "spinnaker_policy_data" {
  binding {
    role = "roles/storage.admin"

    members = [
      "serviceAccount:${google_service_account.spinnaker_account.email}",
      "user:allanasodreferreira@gmail.com"
    ]
  }
}

resource "google_storage_bucket_iam_policy" "bucket_spinnaker_config_iam_policy" {
  bucket = google_storage_bucket.spinnaker_config_bucket.name
  policy_data = data.google_iam_policy.spinnaker_policy_data.policy_data

  depends_on = [google_storage_bucket.spinnaker_config_bucket, google_service_account.spinnaker_account]
}

resource "google_storage_bucket_iam_policy" "bucket_spinnaker_manifests_iam_policy" {
  bucket = google_storage_bucket.spinnaker_manifests_bucket.name
  policy_data = data.google_iam_policy.spinnaker_policy_data.policy_data

  depends_on = [google_storage_bucket.spinnaker_manifests_bucket, google_service_account.spinnaker_account]
}

