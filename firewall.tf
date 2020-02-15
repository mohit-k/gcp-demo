resource "google_compute_firewall" "ssh" {
  name    = "${var.name}-ssh"
  network = "${google_compute_subnetwork.meetup.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

