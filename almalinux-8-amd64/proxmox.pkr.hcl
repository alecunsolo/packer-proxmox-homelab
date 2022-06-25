source "proxmox" "almalinux" {
  proxmox_url              = local.proxmox_url
  node                     = var.proxmox_node
  insecure_skip_tls_verify = var.proxmox_skip_verify_tls

  iso_url          = local.use_iso_file ? null : var.iso_url
  iso_storage_pool = var.iso_storage_pool
  iso_file         = local.use_iso_file ? "${var.iso_storage_pool}:iso/${var.iso_file}" : null
  iso_checksum     = var.iso_checksum
  unmount_iso      = true

  template_name        = var.template_name
  template_description = var.template_description
  vm_name              = var.vm_name
  vm_id                = var.template_vm_id

  os              = "l26"
  qemu_agent      = true
  memory          = var.memory
  cores           = var.cores
  sockets         = var.sockets
  scsi_controller = "virtio-scsi-pci"

  http_directory    = "http"
  http_bind_address = var.http_bind_address
  http_port_min     = var.http_server_port
  http_port_max     = var.http_server_port
  http_interface    = var.http_interface
  vm_interface      = var.vm_interface

  dynamic "network_adapters" {
    for_each = var.network_adapters

    content {
      model       = "virtio"
      firewall    = true
      vlan_tag    = network_adapters.value.vlan_tag
      bridge      = network_adapters.value.bridge
      mac_address = network_adapters.value.mac_address
    }
  }

  dynamic "disks" {
    for_each = var.disks

    content {
      disk_size         = "${disks.value.disk_size}G"
      storage_pool      = disks.value.storage_pool
      storage_pool_type = disks.value.storage_pool_type
    }
  }

  # boot_command = ["<tab> text inst.ks=${local.http_url}/ks.cfg<enter><wait>"]
  boot_command = [
    "<tab><wait>",
    " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter>"
  ]

  boot_wait = "5s"

  ssh_handshake_attempts    = 100
  ssh_username              = var.ssh_username
  ssh_password              = var.ssh_password
  ssh_private_key_file      = data.sshkey.install.private_key_path # May fail validation
  ssh_clear_authorized_keys = true
  ssh_timeout               = "45m"
  ssh_agent_auth            = var.ssh_agent_auth

  cloud_init              = true
  cloud_init_storage_pool = local.cloud_init_storage_pool
}
