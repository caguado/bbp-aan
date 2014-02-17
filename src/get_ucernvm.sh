#!/bin/bash
VERSION="1.16-3"
UCVM_REPO="http://cernvm.cern.ch/releases"
UCVM_DIR="ucernvm-images.${VERSION}.cernvm.x86_64"
UCVM_IMAGE="ucernvm-prod.${VERSION}.cernvm.x86_64.hdd"
FORMAT="vdi"
UCVM_BOOT="ucernvm.vdi"

[ ! -f ${UCVM_IMAGE} ] && wget ${UCVM_REPO}/${UCVM_DIR}/${UCVM_IMAGE} -O ${UCVM_IMAGE}
qemu-img convert -O ${FORMAT} ${UCVM_IMAGE} ${UCVM_BOOT}
chmod 0644 ${UCVM_BOOT}
