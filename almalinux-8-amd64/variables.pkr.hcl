variable "proxmox_host" {
  type        = string
  description = "Proxmox url"
}

variable "proxmox_port" {
  type        = number
  description = "Proxmox url"
  default     = null
}

variable "proxmox_skip_verify_tls" {
  type        = bool
  description = "Skip TLS check on proxmox host"
  default     = false
}

variable "proxmox_node" {
  type        = string
  description = "Proxmox node use for the build"
}

variable "iso_url" {
  type        = string
  description = "URL to an ISO file to upload to Proxmox, and then boot from."
  default     = "http://almalinux.mirror.garr.it/8.6/isos/x86_64/AlmaLinux-8.6-x86_64-boot.iso"
}

variable "iso_storage_pool" {
  type        = string
  description = "Proxmox storage pool onto which to find or upload the ISO file."
  default     = "local"
}

variable "iso_file" {
  type        = string
  description = "Filename of the ISO file to boot from."
  default     = null # "AlmaLinux-8.6-x86_64-boot.iso"
}

variable "iso_checksum" {
  type        = string
  description = "Checksum of the ISO file."
  default     = null
}

variable "vm_name" {
  type        = string
  description = "Name of the virtual machine during creation. If not given, a random uuid will be used."
  default     = null
}

variable "template_name" {
  type        = string
  description = "The VM template name."
  default     = "AlmalinuxCloudInit"
}

variable "template_description" {
  type        = string
  description = "Description of the VM template."
  default     = "Custom cloud init image of Almalinux"
}

variable "template_vm_id" {
  type        = number
  description = "The ID used to reference the virtual machine. This will also be the ID of the final template. If not given, the next free ID on the node will be used."
  default     = null
}

variable "memory" {
  type        = number
  description = "How much memory, in megabytes, to give the virtual machine."
  default     = 512
}

variable "cores" {
  type        = number
  description = "How many CPU cores to give the virtual machine."
  default     = 1
}

variable "sockets" {
  type        = number
  description = "How many CPU sockets to give the virtual machine."
  default     = 1
}

variable "hostname" {
  type        = string
  description = "The vm hostname"
  default     = "packer-template"
}

variable "http_server_host" {
  type        = string
  description = "Overrides packers {{ .HTTPIP }} setting in the boot commands. Useful when running packer in WSL2."
  default     = null
}

variable "http_server_port" {
  type        = number
  description = "The port to serve the http_directory on. Overrides packers {{ .HTTPPort }} setting in the boot commands. Useful when running packer in WSL2."
  default     = null
}

variable "http_bind_address" {
  type        = string
  description = "This is the bind address for the HTTP server. Defaults to 0.0.0.0 so that it will work with any network interface."
  default     = null
}

variable "http_interface" {
  type        = string
  description = "Name of the network interface that Packer gets HTTPIP from."
  default     = null
}

variable "vm_interface" {
  type        = string
  description = "Name of the network interface that Packer gets the VMs IP from."
  default     = null
}

variable "network_adapters" {
  type = list(object({
    bridge      = string
    vlan_tag    = string
    mac_address = string
  }))
  description = "The network interfaces of the vm"
}

variable "disks" {
  type = list(object({
    disk_size         = number
    storage_pool      = string
    storage_pool_type = string
  }))
  description = "The disks of the vm"
}

variable "root_password" {
  type        = string
  description = "root password to use during the setup process. A random password will be used if null."
  default     = null
  sensitive   = true
}

variable "ssh_username" {
  type        = string
  description = "The username to connect to SSH with."
  default     = "packer"
}

variable "ssh_password" {
  type        = string
  description = "A plaintext password to use to authenticate with SSH."
  default     = "packer"
}

variable "ssh_private_key_file" {
  type        = string
  description = "Path to private key file for SSH authentication."
  default     = null
}

variable "ssh_public_key" {
  type        = string
  description = "Public key data for SSH authentication."
  default     = null
}

variable "ssh_agent_auth" {
  type        = bool
  description = "Whether to use an exisiting ssh-agent to pass in the SSH private key passphrase."
  default     = false
}

variable "language" {
  type        = string
  description = "The system language set during the kickstart install."
  default     = "en_US.UTF-8"
}

variable "keyboard_layout" {
  type        = string
  description = "Sets the keyboard layout during the kickstart install."
  default     = "us"
}

variable "keyboard_keymap" {
  type        = string
  description = "Sets the keyboard VConsole keymap during the kickstart install."
  default     = "us"
}

variable "timezone" {
  type        = string
  description = "Sets the timezone during the kickstart install."
  default     = "Etc/UTC"
}

variable "create_swap" {
  type        = bool
  description = "Whether to create a swap partition or not"
  default     = true
}

variable "ntp_servers" {
  type        = list(string)
  description = "The ntp server to use for time synchronization"
  default     = []
}

variable "cloud_init_storage_pool" {
  type        = string
  description = "Name of the Proxmox storage pool to store the Cloud-Init CDROM on. If not given, the storage pool of the boot device will be used (disk_storage_pool)."
  default     = null
}
