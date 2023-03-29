resource "yandex_compute_instance" "srv1" {
  name        = "srv1"
  platform_id = "standard-v1"
  zone        = var.zone
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd80jdh4pvsj48qftb3d"
      size = 25
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.mysubnet.id
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}