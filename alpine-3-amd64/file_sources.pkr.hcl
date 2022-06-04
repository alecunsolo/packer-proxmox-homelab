source "file" "bootstrap" {
  content = templatefile("${path.root}/templates/bootstrap.sh.pkrtpl", {
    disk_device     = local.disk_device
    timezone        = var.timezone
    hostname        = var.hostname
    keyboard_layout = var.keyboard_layout
    keyboard_keymap = var.keyboard_keymap
    create_swap     = var.create_swap
  })
  target = "${path.root}/http/bootstrap.sh"
}

source "file" "setup" {
  content = templatefile("${path.root}/templates/setup.sh.pkrtpl", {
    ssh_public_key = data.sshkey.install.public_key
    create_swap    = var.create_swap
  })
  target = "${path.root}/http/setup.sh"
}
