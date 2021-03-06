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
  default     = "https://dl-cdn.alpinelinux.org/alpine/v3.16/releases/x86_64/alpine-virt-3.16.0-x86_64.iso"
}

variable "iso_storage_pool" {
  type        = string
  description = "Proxmox storage pool onto which to find or upload the ISO file."
  default     = "local"
}

variable "iso_file" {
  type        = string
  description = "Filename of the ISO file to boot from."
  default     = null # "alpine-virt-3.15.0-x86_64.iso"
}

variable "iso_checksum" {
  type        = string
  description = "Checksum of the ISO file."
  default     = "ba8007f74f9b54fbae3b2520da577831b4834778a498d732f091260c61aa7ca1"
}

variable "vm_name" {
  type        = string
  description = "Name of the virtual machine during creation. If not given, a random uuid will be used."
  default     = null
}

variable "template_name" {
  type        = string
  description = "The VM template name."
  default     = "alpine-3-template-cloudinit"
}

variable "template_description" {
  type        = string
  description = "Description of the VM template."
  default     = "Base template for Alpine 3."
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

variable "create_swap" {
  type        = bool
  description = "Whether to create a swap partition or not"
  default     = true
}

variable "locale" {
  type        = string
  description = "sets the locale for the system."
  default     = "en_US.UTF-8"
}

variable "keyboard_layout" {
  type        = string
  description = "sets the keyboard layout during the kickstart install."
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

variable "growpart_devices" {
  type        = list(string)
  description = "List of devices to grow using cloud-init growpart"
  default     = ["/"]
}
