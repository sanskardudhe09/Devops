# Defining VM Volume
resource "libvirt_volume" "devops-qcow" {
  name = each.value
  pool = "default" # List storage pools using virsh pool-list
  source = "/var/lib/libvirt/images/fedora-template.qcow2"
  format = "qcow2"
  for_each = var.volume
}


# Define KVM domain to create
resource "libvirt_domain" "devops-VMs" {
  name   = each.value
  memory = each.value == "jenkins" ? "4096" : "6144"
  vcpu   = each.value == "jenkins" ? 3 : 4

  network_interface {
    network_name = "default" # List networks with virsh net-list
  }

  disk {
    volume_id = "${libvirt_volume.devops-qcow[format("%s.qcow2",each.value)].id}"
  }
  for_each = toset(var.domain)
}

