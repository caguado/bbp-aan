#!/bin/bash
UCVM_IMAGE=ucernvm-images.1.15-7.cernvm.x86_64

wget http://cernvm.cern.ch/releases/${UCVM_IMAGE}/${UCVM_IMAGE}.hdd -O ${UCVM_IMAGE}.hdd
qemu-img convert -O vmdk ${UCVM_IMAGE}.hdd cernvm_image.vmdk
