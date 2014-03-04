#!/bin/sh

CONTEXT_FILE="${1:-context.iso}"

tmpdir=`mktemp -dp /tmp`

cat <<EOF >$tmpdir.user_data
#!/bin/sh
. /etc/cernvm/site.conf
#!/bin/bash

env > /tmp/.environment

cat <<EOP1> /etc/cvmfs/config.d/bbp.epfl.ch.local
CVMFS_HTTP_PROXY='DIRECT'
CVMFS_CACHE_BASE='/var/lib/cvmfs'
CVMFS_SERVER_URL='http://cvmfs-stratum-one.cern.ch/opt/@org@'
CVMFS_FORCE_SIGNING='yes'
EOP1

exit

[amiconfig]
plugins=cernvm

[cernvm]
organisations=bbp
repositories=bbp.epfl.ch,sft.cern.ch
shell=/bin/bash
config_url=http://cernvm.cern.ch/config
users=bbpaan:bbpaan:password
contextualization_command=bbpaan:/cvmfs/bbp.epfl.ch/external/cernvm-copilot/bin/copilot-context
edition=uCernVM

[ucernvm-begin]
[ucernvm-end]
EOF

user_data64=`base64 --wrap=0 $tmpdir.user_data`

cat <<EOF >$tmpdir/context.sh
# Context variables used by amiconfig
EC2_USER_DATA="$user_data64"
ONE_CONTEXT_PATH="/var/lib/amiconfig"
EOF

touch ${tmpdir}/prolog.sh

mkisofs -o ${CONTEXT_FILE} ${tmpdir}
rm -rf ${tmpdir}
