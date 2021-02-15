##########################
# 変数
##########################
variable "team_name" {}
variable "gcp_project_name" {}
variable "title" {
  type = string
  default = "isucon-no-susume"
}


##########################
# セットアップ
##########################
provider "google" {
  credentials = file("../credentials.json")
  project     = var.gcp_project_name
  region      = "asia-northeast1"
}

##########################
# リソース構築
##########################
resource "google_compute_network" "isucon9q" {
  name                    = "${var.title}-vpc-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "isucon9q" {
  name          = "${var.title}-${var.team_name}-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "asia-northeast1"
  network       = google_compute_network.isucon9q.self_link
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "isucon9q" {
  name    = "${var.team_name}-isucon9q-ports"
  network = google_compute_network.isucon9q.self_link

  source_ranges = ["0.0.0.0/0"]
  target_tags = [
    "isucon9q-ports"
  ]

  allow {
    protocol = "tcp"
    ports    = [
      "22",
      "3306", # for MySQL
      "5555", # for ISUCARI
      "7000", # for ISUCARI
      "8000", # for ISUCARI
      "19999" # for Netdata
    ]
  }
}

resource "google_compute_address" "isucon9q" {
  name         = "${var.team_name}-isucon9q-sip"
}

resource "google_compute_instance" "isucon9q" {
  name         = "${var.team_name}-isucon9q"
  machine_type = "n1-standard-1"
  zone         = "asia-northeast1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = 20
    }
  }

  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = google_compute_network.isucon9q.self_link
    subnetwork = google_compute_subnetwork.isucon9q.self_link

    access_config {
      network_tier = "PREMIUM"
      nat_ip = google_compute_address.isucon9q.address
    }
  }

  tags = [
    "http-server",
    "isucon9q-ports",
  ]

  metadata_startup_script = "echo hi > /test.txt"
}

