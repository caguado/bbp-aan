#!/bin/bash

CACHE_SIZE="16384"
CACHE_FILE="${1:-cache.vdi}"
CACHE_FORMAT="VDI"

vboxmanage createhd --filename ${CACHE_FILE} --size ${CACHE_SIZE} --format ${CACHE_FORMAT}
chmod 0644 ${CACHE_FILE}
