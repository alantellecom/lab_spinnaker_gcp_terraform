resource "google_pubsub_topic" "gcr" {
  name = "gcr"
}

resource "google_pubsub_subscription" "gcr-triggers" {
  name  = "gcr-triggers"
  topic = google_pubsub_topic.gcr.name
}

resource "google_pubsub_subscription_iam_binding" "gcr-triggers_bind" {
  subscription = google_pubsub_subscription.gcr-triggers.name
  role         = "roles/pubsub.subscriber"
  members = [
    "serviceAccount:${google_service_account.spinnaker_account.email}",
  ]
  
  depends_on = [google_service_account.spinnaker_account]
}