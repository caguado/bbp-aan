#!/bin/bash -e

# Versions
WRAPPER_VERSION="7.0.79-1.aan"
UCVM_VERSION="1.17-3"
BBPAAN_VERSION=`git describe`

BASE=`dirname $PWD/$0`
OUTPUT=${BASE}/../data
BBPAAN_TGZ=bbpaan-boinc-${BBPAAN_VERSION}.tgz
JOB_FILE=vbox_job.xml
VERSION_FILE=version.xml
WRAPPER_FILE=vboxwrapper_${BBPAAN_VERSION}_x86_64-pc-linux-gnu__vbox64
UCVM_FILE=ucernvm-${BBPAAN_VERSION}.vdi
CACHE_FILE=cache-${BBPAAN_VERSION}.vdi
CONTEXT_FILE=context-${BBPAAN_VERSION}.iso

tmpdir=`mktemp -dp /tmp`

pushd ${tmpdir}

cp ${BASE}/../data/vboxwrapper-${WRAPPER_VERSION} ${WRAPPER_FILE}

${BASE}/gen_vbox_job.sh
${BASE}/gen_version.sh ${VERSION_FILE} \
	${WRAPPER_FILE} \
	${UCVM_FILE} \
	${CACHE_FILE} \
	${CONTEXT_FILE}

${BASE}/get_ucernvm.sh ${UCVM_VERSION} ${UCVM_FILE}
${BASE}/gen_cache.sh ${CACHE_FILE}
${BASE}/gen_context.sh ${CONTEXT_FILE}

tar czf ${OUTPUT}/${BBPAAN_TGZ} \
	${JOB_FILE} \
	${VERSION_FILE} \
	${WRAPPER_FILE} \
	${UCVM_FILE} \
	${CACHE_FILE} \
	${CONTEXT_FILE}

popd
rm -rf ${tmpdir}
