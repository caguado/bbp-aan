#!/bin/sh

VBOXJOB_FILE="${1:-vbox_job.xml}"

cat <<EOF >"${VBOXJOB_FILE}"
<vbox_job>
  <os_name>Linux26_64</os_name>
  <memory_size_mb>512</memory_size_mb>
  <vm_disk_controller_type>sata</vm_disk_controller_type>
  <vm_disk_controller_model>IntelAHCI</vm_disk_controller_model>
  <enable_network/>
  <enable_floppyio/>
  <enable_cache_disk/>
  <enable_isocontextualization/>
  <enable_remotedesktop/>
  <enable_cern_dataformat/>
  <job_duration>21600</job_duration>
  <pf_guest_port>80</pf_guest_port>
  <pf_host_port>7859</pf_host_port>
</vbox_job>
EOF

