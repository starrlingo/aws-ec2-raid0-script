#!/usr/bin/env bash
umount /opt/aws/task_runner
yes | mdadm --create --verbose /dev/md0 --level=stripe --raid-devices=2 /dev/xvdb /dev/xvdc
/sbin/blockdev --setra 65536 /dev/md0
mkfs.ext4 /dev/md0
mount -t ext4 /dev/md0 /opt/aws/task_runner