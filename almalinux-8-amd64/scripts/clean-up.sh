#!/bin/bash

set -xeu
rm -f /tmp/00_custom_cloud.cfg
userdel -f -r $SSH_USERNAME
