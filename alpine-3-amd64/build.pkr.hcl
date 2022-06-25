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

locals {
  use_iso_file            = var.iso_file != null ? true : false
  cloud_init_storage_pool = coalesce(var.cloud_init_storage_pool, var.disks[0].storage_pool)
  disk_device             = "/dev/sda"
}

data "sshkey" "install" {
}

build {

  sources = [
    "source.file.bootstrap",
    "source.file.setup",
    "source.proxmox.alpine"
  ]

  provisioner "file" {
    content = templatefile("${path.root}/templates/00_custom_cloud.cfg.pkrtpl", {
      locale      = var.locale
      timezone    = var.timezone
      ntp_servers = var.ntp_servers
      devices     = var.growpart_devices
    })
    destination = "/tmp/00_custom_cloud.cfg"
  }

  provisioner "shell" {
    scripts = [
      "scripts/cloud-init.sh",
      "scripts/clean-up.sh"
    ]
  }
}
