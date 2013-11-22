#!/bin/sh

tmpdir=`mktemp -dp /tmp`

cat <<EOF >$tmpdir.user_data
#!/bin/sh
. /etc/cernvm/site.conf
#!/bin/bash

env > /tmp/environment
exit
[amiconfig]
plugins=cernvm

[cernvm]
organisations=None
repositories=bbp
shell=/bin/bash
config_url=http://cernvm.cern.ch/config
contextualization_command=bbpadmin:'/usr/bin/env >> /tmp/context'
services=copilot
users=bbpaan:bbpaan:password
edition=uCernVM

[ucernvm-begin]
cvmfs_branch=cernvm-testing.cern.ch
[ucernvm-end]
EOF

user_data64=`base64 --wrap=0 $tmpdir.user_data`

cat <<EOF >$tmpdir/context.sh
# Context variables used by amiconfig
EC2_USER_DATA="$user_data64"
ONE_CONTEXT_PATH="/var/lib/amiconfig"
EOF

touch $tmpdir/prolog.sh

mkisofs -o context.iso $tmpdir
