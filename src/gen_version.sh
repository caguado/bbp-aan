#!/bin/sh

VERSION_FILE="${1:-version.xml}"
WRAPPER_FILE="${2:-vboxwrapper_1_x86_64-pc-linux-gnu__vbox64}"
UCVM_FILE="${3:-ucernvm.vdi}"
CACHE_FILE="${4:-cache.vdi}"
CONTEXT_FILE="${5:-context.iso}"

cat <<EOF >"${VERSION_FILE}"
<version>
  <file>
    <physical_name>${WRAPPER_FILE}</physical_name>
    <main_program/>
    <copy_file/>
  </file>
  <file>
    <physical_name>${UCVM_FILE}</physical_name>
    <logical_name>vm_image.vdi</logical_name>
    <copy_file/>
    <gzip/>
  </file>
  <file>
    <physical_name>${CACHE_FILE}</physical_name>
    <logical_name>vm_cache.vdi</logical_name>
    <copy_file/>
    <gzip/>
  </file>
  <file>
    <physical_name>${CONTEXT_FILE}</physical_name>
    <logical_name>vm_isocontext.iso</logical_name>
    <copy_file/>
    <gzip/>
  </file>
  <dont_throttle/>
  <needs_network/>
</version>
EOF

