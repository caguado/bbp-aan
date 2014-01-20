#!/bin/bash
UCVM_REPO="http://cernvm.cern.ch/releases"
UCVM_DIR="ucernvm-images.1.15-7.cernvm.x86_64"
UCVM_IMAGE="ucernvm-testing.1.15-7.cernvm.x86_64.hdd"

wget ${UCVM_REPO}/${UCVM_DIR}/${UCVM_IMAGE} -O ${UCVM_IMAGE}
qemu-img convert -O vmdk ${UCVM_IMAGE} ucernvm.vmdk
