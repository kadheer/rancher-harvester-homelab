
---

## 📄 terraform/main.tf

```hcl
terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

# Gemeinsames Netzwerk (NAT oder Bridge)
resource "libvirt_network" "homelab_net" {
  name      = "homelab"
  mode      = "nat"
  domain    = "homelab.local"
  addresses = ["192.168.122.0/24"]
  dhcp {
    enabled = true
  }
}

# Gemeinsame Basis-Konfiguration für alle VMs
locals {
  common_settings = {
    memory = var.vm_memory
    vcpu   = var.vm_vcpu
    disk_size = var.disk_size_gb
    network_interface = {
      network_id = libvirt_network.homelab_net.id
    }
  }
}

# Rancher VM
resource "libvirt_domain" "rancher" {
  name   = "rancher-server"
  memory = var.rancher_memory
  vcpu   = var.rancher_vcpu

  disk {
    volume_id = libvirt_volume.rancher_disk.id
  }

  network_interface {
    network_id = libvirt_network.homelab_net.id
  }

  console {
    type        = "pty"
    target_port = "0"
  }
}

resource "libvirt_volume" "rancher_disk" {
  name           = "rancher.qcow2"
  base_volume_id = libvirt_volume.ubuntu_base.id
  size           = var.rancher_disk_gb * 1024 * 1024 * 1024
}

# Harvester Node 1
resource "libvirt_domain" "harvester1" {
  name   = "harvester-node1"
  memory = var.harvester_memory
  vcpu   = var.harvester_vcpu

  disk {
    volume_id = libvirt_volume.harvester1_disk.id
  }

  network_interface {
    network_id = libvirt_network.homelab_net.id
  }
}

resource "libvirt_volume" "harvester1_disk" {
  name           = "harvester1.qcow2"
  base_volume_id = libvirt_volume.ubuntu_base.id
  size           = var.harvester_disk_gb * 1024 * 1024 * 1024
}

# Harvester Node 2
resource "libvirt_domain" "harvester2" {
  name   = "harvester-node2"
  memory = var.harvester_memory
  vcpu   = var.harvester_vcpu

  disk {
    volume_id = libvirt_volume.harvester2_disk.id
  }

  network_interface {
    network_id = libvirt_network.homelab_net.id
  }
}

resource "libvirt_volume" "harvester2_disk" {
  name           = "harvester2.qcow2"
  base_volume_id = libvirt_volume.ubuntu_base.id
  size           = var.harvester_disk_gb * 1024 * 1024 * 1024
}

# Base-Image (Ubuntu Cloud-Image)
resource "libvirt_volume" "ubuntu_base" {
  name   = "ubuntu-jammy-base"
  source = var.ubuntu_image_url
  format = "qcow2"
}
