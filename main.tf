data "google_project" "current" {
}

data "google_compute_default_service_account" "default" {
  project = "${var.project}"
}

resource "google_compute_instance" "meetup" {
  count                     = "${var.num_nodes}"
  name                      = "${var.name}-${count.index + 1}"
  zone                      = "${var.zone}"
  machine_type              = "${var.machine_type}"
  min_cpu_platform          = "${var.min_cpu_platform}"
  allow_stopping_for_update = true

  boot_disk {
    auto_delete = "${var.disk_auto_delete}"

    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20191021"
      size  = "${var.disk_size_gb}"
      type  = "${var.disk_type}"
    }
  }

  network_interface {
    subnetwork    = "${google_compute_subnetwork.meetup.name}"
    #access_config = {}
    #address       = "${var.network_ip}"
  }

  metadata = "${merge(
    map("startup-script", "${var.startup_script}", "tf_depends_id", "${var.depends_id}"),
    var.metadata
  )}"

  service_account {
    email  = "${var.service_account_email == "" ? data.google_compute_default_service_account.default.email : var.service_account_email }"
    scopes = "${var.service_account_scopes}"
  }
}

