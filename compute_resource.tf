
resource "google_compute_address" "static" {
	name="ipv4-address"
}
resource "google_compute_instance" "ansibleready"{
	name = "ansibleready"
	machine_type = "n1-standard-1"
	zone = "europe-west2-c"
	tags = ["ansible"]
	boot_disk {
		initialize_params {
			image = "centos-7-v20190423"
		}
	}
	network_interface {
		network = "default"
		access_config {
			nat_ip = "${google_compute_address.static.address}"
		}
	}
	metadata{
		sshKeys = "mzgadd:${file("/home/mzgadd/.ssh/id_rsa.pub")}"
	}
	provisioner "file"{
		source = "setup.sh"
		destination = "/tmp/setup.sh"
	}
	connection = {
		type = "ssh"
		user = "mzgadd"
		private_key = "${file("/home/mzgadd/.ssh/id_rsa")}"
	}
}
resource "null_resource" "setup_ansible_and_git"{
	depends_on = ["google_compute_instance.ansibleready"]
	connection = {
		host = "${google_compute_address.static.address}"
		type = "ssh"
		user = "mzgadd"
		private_key = "${file("/home/mzgadd/.ssh/id_rsa")}"
	}
	provisioner "remote-exec"{
		inline = [
				"sudo yum install dos2unix -y",
				"dos2unix /tmp/setup.sh",
				"chmod +x /tmp/setup.sh",
				"sudo sh /tmp/setup.sh",
			]
	}
}
