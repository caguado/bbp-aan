#!/bin/bash

UCVM_SIZE=16384
UCVM_CACHE=cache.vdi

vboxmanage createhd --filename ${UCVM_CACHE} --size ${UCVM_SIZE} --format VDI
chmod 0644 ${UCVM_CACHE}
