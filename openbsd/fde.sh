#!/bin/sh
set -e
drive='/dev/rsd0c'
echo "DANGER! All data on $drive will be erased. Press CTRL-C to cancel."
read -r
dd if=/dev/urandom of="$drive" bs=1m count=1 status=none
fdisk -iy sd0 >/dev/null
disklabel -E sd0 >/dev/null << EOF
z
a a
1024
*
RAID
w
q
EOF
bioctl -c C -l sd0a softraid0
cd /dev && sh MAKEDEV sd3
dd if=/dev/zero of=/dev/rsd3c bs=1m count=1 status=none
echo 'Done! Please exit this shell to return to the main installer.'
