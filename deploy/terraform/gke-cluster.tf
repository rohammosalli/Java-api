resource "google_container_cluster" "gke-cluster" {
  name     = "pipedrive-cluster"
  location = "europe-north1-a"
  remove_default_node_pool = true
  initial_node_count = 1
  timeouts {
    create = "30m"
    update = "20m"
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "gke-node-pool"
  location   = "europe-north1-a"
  cluster    = "${google_container_cluster.gke-cluster.name}"
  node_count = 3
  timeouts {
    create = "30m"
    update = "20m"
  }
}