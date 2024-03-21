# Указать свое значение folder_id 
variable "folder_id" {
  description = "Yandex Folder id"
  type = string
  default = "b1gnlpou7uq9a09incdo"
}

# Указать свое значение cloud_id 
variable "cloud_id" {
  description = "Yandex Cloud id"
  type = string
  default = "b1gqltuvac50rpng072t"
}

# Указать зону где нужно создать инфраструктуру
variable "zone" {
    description = "Zone infra"
    type = string
    default = "ru-central1-b"
}