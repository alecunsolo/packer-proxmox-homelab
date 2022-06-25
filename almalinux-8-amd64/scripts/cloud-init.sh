#!/bin/bash

set -xe
dnf install -y cloud-init \
               cloud-utils-growpart \
               parted

install -o root -g root -m 644 /tmp/00_custom_cloud.cfg /etc/cloud/cloud.cfg.d/
