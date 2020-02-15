resource "google_compute_network" "meetup" {
  name                    = "${var.network_name}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "meetup" {
  name                     = "${var.network_name}"
  ip_cidr_range            = "${var.network_cidr}"
  network                  = "${google_compute_network.meetup.self_link}"
  region                   = "${var.region}"
  private_ip_google_access = true
}
