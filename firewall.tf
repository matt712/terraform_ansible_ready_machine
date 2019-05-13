resource "google_compute_firewall" "firewall"{
	name = "${var.name}-firewall"
	network = "${var.network}"
	target_tags = ["${var.name}"]
	source_ranges = ["0.0.0.0/0"]

	allow {
		protocol = "icmp"
	}
	allow {
		protocol = "tcp"
		ports = ["80", "443"]
	}
}
