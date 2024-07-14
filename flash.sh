#!/bin/bash
if [[ $# -ne 1 ]] ; then
  echo "Must provide one argument - 'left' or 'right'."
  exit 1
fi
side=$1
sudo umount -q /mnt/d
sudo mount -t drvfs D: /mnt/d
if ! ls -1 /mnt/d | egrep -i "^current.uf2$" >/dev/null ; then
  echo "Couldn't find 'current.uf2' for $side side."
  exit 1
fi
if ! cp $side.uf2 /mnt/d ; then
  echo "Couldn't copy '$side.uf2' to target drive."
  exit 1
fi
exit 0
