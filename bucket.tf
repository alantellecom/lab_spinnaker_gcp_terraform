resource "google_storage_bucket" "spinnaker_config_bucket" {
  name          = "spinnaker_config_bucket"
  location      = "SOUTHAMERICA-EAST1"
  storage_class = "REGIONAL"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = "1"
    }
    action {
      type = "Delete"
    }
  }
  
}



resource "google_storage_bucket" "spinnaker_manifests_bucket" {
  name          = "spinnaker_manifests_bucket"
  location      = "SOUTHAMERICA-EAST1"
  storage_class = "REGIONAL"
  force_destroy = true
  
  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = "1"
    }
    action {
      type = "Delete"
    }
  }
}

