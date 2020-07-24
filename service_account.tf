resource "google_service_account" "spinnaker_account" {
  account_id   = "spinnaker-account"
  display_name = "spinnaker-account"
}

resource "google_service_account_key" "mykey" {
  service_account_id = google_service_account.spinnaker_account.name
  
  depends_on = [google_service_account.spinnaker_account]
}

resource "local_file" "spinnaker-sa-json" {
    content     = base64decode(google_service_account_key.mykey.private_key)
    filename = "./spinnaker-sa.json"

    depends_on = [google_service_account_key.mykey]
}