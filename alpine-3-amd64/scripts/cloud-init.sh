#!/bin/sh
apk add cloud-init cloud-utils-growpart e2fsprogs-extra
install -o root -g root -m 644 /tmp/00_custom_cloud.cfg /etc/cloud/cloud.cfg.d/

# Add iso9660 as a valid filesystem. Necessary for cloud-init to mount NoData with proxmox cloud-init drive (/dev/sr[0-9]).
echo 'isofs' > /etc/modules-load.d/isofs.conf
chmod -x /etc/modules-load.d/isofs.conf
setup-cloud-init
