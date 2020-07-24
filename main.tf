
# GKE cluster
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  remove_default_node_pool = true
  initial_node_count = 1

  network    = "default"
  subnetwork = "default"

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 1

   autoscaling { 
    min_node_count = 1
    max_node_count = 2
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    labels = {
      env = var.project
    }

    preemptible  = true
    machine_type = "n1-standard-1"
    tags         = ["gke-node", "${var.project}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

resource "null_resource" "helm_script" {

  depends_on = [google_container_node_pool.primary_nodes]
  
  provisioner "local-exec" {
    command = "chmod +x ./helm.sh && ./helm.sh"
     interpreter = ["/bin/bash", "-c"]
  }
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [null_resource.helm_script]

  create_duration = "30s"
}

resource "null_resource" "spinnaker_script" {

  depends_on = [time_sleep.wait_30_seconds]
  
  provisioner "local-exec" {
    command = "chmod +x ./start-spinnaker.sh && ./start-spinnaker.sh"
     interpreter = ["/bin/bash", "-c"]
  }
}

resource "time_sleep" "wait_300_seconds" {
  depends_on = [null_resource.spinnaker_script]

  create_duration = "300s"
}

resource "null_resource" "svc_spinnaker_script" {

  depends_on = [time_sleep.wait_300_seconds]
  
  provisioner "local-exec" {
    command = "chmod +x ./svc-spinnaker.sh && ./svc-spinnaker.sh"
     interpreter = ["/bin/bash", "-c"]
  }
}
