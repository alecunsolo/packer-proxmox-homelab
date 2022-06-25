source "file" "kickstart" {
  content = templatefile("${path.root}/templates/ks.cfg.pkrtpl", {
    language        = var.language
    timezone        = var.timezone
    hostname        = var.hostname
    keyboard_layout = var.keyboard_layout
    keyboard_keymap = var.keyboard_keymap
    ssh_username    = var.ssh_username
    ssh_password    = bcrypt(var.ssh_password, 6)
    ssh_public_key  = local.ssh_public_key
    create_swap     = var.create_swap
  })
  target = "${path.root}/http/ks.cfg"
}
