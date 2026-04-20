output "rancher_ip" {
  value = libvirt_domain.rancher.network_interface.0.addresses.0
}

output "harvester1_ip" {
  value = libvirt_domain.harvester1.network_interface.0.addresses.0
}

output "harvester2_ip" {
  value = libvirt_domain.harvester2.network_interface.0.addresses.0
}
