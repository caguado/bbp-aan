#!/bin/bash

UCVM_VERSION="$1"
UCVM_REPO="http://cernvm.cern.ch/releases"
UCVM_DIR="ucernvm-images.${UCVM_VERSION}.cernvm.x86_64"
UCVM_IMAGE="ucernvm-prod.${UCVM_VERSION}.cernvm.x86_64.hdd"
FORMAT="vdi"
UCVM_FILE="${2:-ucernvm.vdi}"

[ ! -f "${UCVM_IMAGE}" ] && wget "${UCVM_REPO}/${UCVM_DIR}/${UCVM_IMAGE}" -O "${UCVM_IMAGE}"
qemu-img convert -O "${FORMAT}" "${UCVM_IMAGE}" "${UCVM_FILE}"
chmod 0644 "${UCVM_FILE}"
rm -f "${UCVM_IMAGE}"
