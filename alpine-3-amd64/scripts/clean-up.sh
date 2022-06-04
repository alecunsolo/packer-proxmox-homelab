!#/bin/sh
shred -u /etc/ssh/*_key /etc/ssh/*_key.pub
unset HISTFILE; rm -rf /home/*/.*history /root/.*history
passwd -d root
passwd -l root
