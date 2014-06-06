#!/bin/sh

CONTEXT_FILE="${1:-context.iso}"

tmpdir=`mktemp -dp /tmp`

# Do not expand variables now
cat <<"EOF" >$tmpdir/user-data
#cloud-config
groups:
  - bbpaan

users:
  - name: bbpaan
    gecos: bbpaan
    primary-group: bbpaan
    groups: floppy
    shell: /bin/bash
    lock-passwd: false
    passwd: $6$PuVRHFb7$6S3385gZELg5HvKUCYEt9L7Y7UvqEWLLb3bGwsnNAR2iyAJCQZAv6f4.c97jmCAAPSWeyFBE7L9EoHPeqIO.S.

write_files:
  - owner: root:root
    path: /etc/cvmfs/config.d/bbp.epfl.ch.conf
    permissions: '0644'
    content: |
      CVMFS_CACHE_BASE='/var/lib/cvmfs'
      CVMFS_SERVER_URL='http://cvmfs-stratum-one.cern.ch/cvmfs/bbp.epfl.ch;http://cvmfs.racf.bnl.gov/cvmfs/bbp.epfl.ch'
      CVMFS_FORCE_SIGNING='yes'

runcmd:
  - su - bbpaan -c /cvmfs/bbp.epfl.ch/external/cernvm-copilot/bin/copilot-context &

EOF

cat <<"EOF" >$tmpdir/meta-data
EOF

genisoimage  -output "${CONTEXT_FILE}" -volid cidata -joliet -rock $tmpdir/user-data $tmpdir/meta-data
rm -rf ${tmpdir}
