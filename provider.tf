provider "google" {
  credentials = "${file("/home/mohitk/leisure/meetup/mohit-project-267909-3e658ae18025.json")}"
  project = "${var.project}"
  region = "${var.region}"
}
