resource "google_compute_firewall" "firewall"{
	name = "ansiblefirewall"
	network = "default"
	target_tags = ["ansible"]
	source_ranges = ["0.0.0.0/0"]

	allow {
		protocol = "icmp"
	}
	allow {
		protocol = "tcp"
		ports = ["80", "443"]
	}
}
