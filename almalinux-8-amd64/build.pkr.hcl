packer {
  required_version = "~> 1.8"
  required_plugins {
    proxmox = {
      version = "~> 1.0.7"
      source  = "github.com/hashicorp/proxmox"
    }
    sshkey = {
      version = "~> 1.0.1"
      source  = "github.com/ivoronin/sshkey"
    }
  }
}

data "sshkey" "install" {
}

locals {
  proxmox_url             = var.proxmox_port != null ? "https://${var.proxmox_host}:${var.proxmox_port}/api2/json" : "https://${var.proxmox_host}/api2/json"
  use_iso_file            = var.iso_file != null ? true : false
  http_url                = join("", ["http://", coalesce(var.http_server_host, "{{ .HTTPIP }}"), ":", coalesce(var.http_server_port, "{{ .HTTPPort }}")])
  ssh_public_key          = data.sshkey.install.public_key
  cloud_init_storage_pool = coalesce(var.cloud_init_storage_pool, var.disks[0].storage_pool)
}

build {
  sources = [
    "source.file.kickstart",
    "source.proxmox.almalinux"
  ]

  provisioner "file" {
    content = templatefile("${path.root}/templates/00_custom_cloud.cfg.pkrtpl", {
      locale      = var.language
      timezone    = var.timezone
      ntp_servers = var.ntp_servers
    })
    destination = "/tmp/00_custom_cloud.cfg"
  }

  # Packages
  provisioner "shell" {
    execute_command = "sudo /bin/sh -c '{{ .Vars }} {{ .Path }}'"
    environment_vars = [
      "SSH_USERNAME=${var.ssh_username}"
    ]
    scripts = [
      "scripts/cloud-init.sh",
      "scripts/common-setup.sh",
      "scripts/clean-up.sh"
    ]
  }
}
