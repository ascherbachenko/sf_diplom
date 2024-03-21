terraform {
  required_providers {
    yandex = {
        source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
    service_account_key_file = "${file("~/.ssh/authorized_key.json")}"
    zone = "ru-central1-b"
    cloud_id    = var.cloud_id
    folder_id   = var.folder_id
}

/*
// Создаем инстанс 1
resource "yandex_compute_instance" "master" {
  name        = "master"
  platform_id = "standard-v1"
  #zone        = "ru-central1-b"
  hostname = "master"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8v0s6adqu3ui3rsuap"
      size     = 20
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
    nat = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
*/

/*
// Создаем инстанс 2
resource "yandex_compute_instance" "app" {
  name        = "app"
  platform_id = "standard-v1"
  zone        = "ru-central1-b"
  hostname = "app"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8v0s6adqu3ui3rsuap"
      size     = 20
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
    nat = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

// Создаем инстанс 3
resource "yandex_compute_instance" "srv" {
  name        = "srv"
  platform_id = "standard-v1"
  zone        = "ru-central1-b"
  hostname = "srv"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8v0s6adqu3ui3rsuap"
      size     = 20
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
    nat = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
*/

// Создаем сеть
resource "yandex_vpc_network" "default" {
    name = "default"
}

//Создаем подсеть
resource "yandex_vpc_subnet" "default" {
    network_id = "${yandex_vpc_network.default.id}"
    v4_cidr_blocks = ["10.5.0.0/24"]  
}

//Подключаем модуль
module "create_cluster" {
  source = "./modules/instance"
  vpc_subnet_id = yandex_vpc_subnet.default.id
  master = 1
  worker = 1
  srv = 1
}

