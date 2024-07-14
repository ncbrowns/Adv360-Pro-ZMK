#!/bin/bash
sudo umount -q /mnt/fspublic
sudo mount -t drvfs '\\fileserver\public' /mnt/fspublic
if [[ ! -d /mnt/fspublic/adv360 ]] ; then
  echo "Couldn't find '\\fileserver\public\adv360'."
  exit 1
fi
for i in left right ; do
  if ! cp $i.uf2 /mnt/fspublic/adv360 ; then
    echo "Couldn't copy '$i.uf2' to '\\fileserver\public\adv360'."
    exit 1
  fi
done
exit 0
