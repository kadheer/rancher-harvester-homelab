# rancher-harvester-homelab

> Aufbau eines kleinen Homelabs mit **Rancher** (Cluster-Management) und **Harvester** (HCI) auf virtuellen Maschinen.  
> Evaluation von **Longhorn-Storage** und **VM-Management** mit Terraform + KVM.

## 🎯 Ziele

- Rancher als zentrale Kubernetes-Management-Plattform installieren
- Harvester als HCI-Layer für VM- & Storage-Orchestrierung
- Longhorn als persistenten Blockstorage evaluieren
- Vollständige VM-Provisionierung mit **Terraform** (libvirt-Provider)
- Grundlegendes VM-Lifecycle-Management über Harvester testen

## 🧱 Architektur (Übersicht)

| Komponente       | Rolle                                      | VM-Spezifikation |
|----------------|--------------------------------------------|------------------|
| Rancher-Server  | Management-Cluster (K8s)                  | 4 vCPU, 8 GB RAM, 50 GB Disk |
| Harvester-Node1 | HCI-Knoten (VM-Hypervisor + Storage)      | 4 vCPU, 16 GB RAM, 100 GB Disk |
| Harvester-Node2 | HCI-Knoten (für High Availability)        | 4 vCPU, 16 GB RAM, 100 GB Disk |
| Longhorn-Test   | Zusätzlicher Node für Storage-Tests       | 2 vCPU, 4 GB RAM, 50 GB Disk |

Alle VMs laufen unter **KVM** (libvirt) auf einem Proxmox oder einer reinen Linux-Bridge.

## 🛠️ Voraussetzungen

- Linux-Host mit KVM (`kvm`, `libvirt`, `virt-manager`)
- Terraform (>= 1.3)
- kubectl, helm (für spätere Interaktion mit Rancher/Harvester)
- ISO-Images: Ubuntu 22.04 / openSUSE Leap (Harvester empfiehlt SLES, aber für Homelab reicht Ubuntu als KVM-Gast)

## 🚀 Setup

### 1. VMs mit Terraform erstellen

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Anpassen: Netzwerk, Pfade zu ISOs, SSH-Keys
terraform init
terraform plan
terraform apply
