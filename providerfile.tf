
provider "google" {
  credentials = "${file("./key.json")}"
  project = "${var.project}"
  region = "europe-west2"
}
