# Architektur-Übersicht

## Netzwerk
- KVM-Host: 192.168.122.1 (NAT)
- Rancher: 192.168.122.10
- Harvester-Node1: 192.168.122.11
- Harvester-Node2: 192.168.122.12

## Speicher
- Longhorn wird auf den Harvester-Nodes über die lokalen Disks bereitgestellt.
- Replikation auf 2 Nodes für HA.

## Integration
- Rancher verwaltet mehrere Cluster: Harvester-Cluster + ggf. einen separaten downstream K8s-Cluster.
- VM-Management in Harvester via Rancher UI (Virtualization Management → Harvester Cluster).
