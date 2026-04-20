variable "ubuntu_image_url" {
  description = "URL des Ubuntu Cloud-Images (qcow2)"
  default     = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

variable "vm_vcpu" {
  default = 2
}
variable "vm_memory" {
  default = 4096
}
variable "disk_size_gb" {
  default = 30
}

variable "rancher_vcpu" {
  default = 2
}
variable "rancher_memory" {
  default = 8192
}
variable "rancher_disk_gb" {
  default = 50
}

variable "harvester_vcpu" {
  default = 4
}
variable "harvester_memory" {
  default = 16384
}
variable "harvester_disk_gb" {
  default = 100
}
