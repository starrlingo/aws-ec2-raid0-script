#!/usr/bin/env bash

print_usage() {
    echo ""
    echo "Usage: $PROGNAME [ -m ]"
    echo "-m Mount Point [Required]"
    echo "i.e.: $PROGNAME -m /test"
    echo ""
}

while getopts "hm:" Option
do
  case $Option in
    m     ) MOUNT_POINT=$OPTARG ;;
    h     ) print_usage
            exit 1;;
  esac
done

if [ -z "${MOUNT_POINT}" ]; then
    print_usage
    exit 1
fi

MOUNT_DISKS=$(blkid -c /dev/null | grep -v "LABEL=\"/\"" | grep -o "/dev/[a-zA-Z]*")
MOUNT_DISK_DEVICES=$( echo ${MOUNT_DISKS} | tr " " "\n" | wc -l)

mkdir -p ${MOUNT_POINT}
# unmount disk
for ((i=0; i<${#MOUNT_DISKS[@]}; i++))
do
  DISK=${MOUNT_DISKS[$i]}
  umount ${DISK} >/dev/null 2>&1
done
# create Raid 0 array
yes | mdadm --create --verbose /dev/md0 --level=stripe --raid-devices=${MOUNT_DISK_DEVICES} $( echo ${MOUNT_DISKS} )
/sbin/blockdev --setra 65536 /dev/md0
mkfs.ext4 /dev/md0
# mount to folder
mount -t ext4 /dev/md0 ${MOUNT_POINT}