#!/bin/bash -e

# Versions
WRAPPER_VERSION="7.0.79-1.aan"
UCVM_VERSION="1.17-5"
BBPAAN_PLATFORMS="x86_64-apple-darwin__vbox64 x86_64-pc-linux-gnu__vbox64"
BBPAAN_VERSION=`git describe`

BASE=`dirname $PWD/$0`
OUTPUT=${BASE}/../data
BBPAAN_TGZ=bbpaan-boinc-${BBPAAN_VERSION}.tgz
JOB_FILE=vbox_job-${BBPAAN_VERSION}.xml
VERSION_FILE=version.xml
UCVM_FILE=ucernvm-${BBPAAN_VERSION}.vdi
CACHE_FILE=cache-${BBPAAN_VERSION}.vdi
CONTEXT_FILE=context-${BBPAAN_VERSION}.iso

WRAPPER_FILEBASE=vboxwrapper_${BBPAAN_VERSION}

tmpdir=`mktemp -dp /tmp`

pushd ${tmpdir}
${BASE}/get_ucernvm.sh ${UCVM_VERSION} ${UCVM_FILE}
${BASE}/gen_cache.sh ${CACHE_FILE}
${BASE}/gen_context.sh ${CONTEXT_FILE}
popd

for BBPAAN_PLATFORM in ${BBPAAN_PLATFORMS}
do
  mkdir -p ${tmpdir}/${BBPAAN_VERSION}/${BBPAAN_PLATFORM}
  pushd ${tmpdir}/${BBPAAN_VERSION}/${BBPAAN_PLATFORM}

  WRAPPER_FILE=${WRAPPER_FILEBASE}_${BBPAAN_PLATFORM}
  cp ${BASE}/../data/vboxwrapper_${WRAPPER_VERSION}_${BBPAAN_PLATFORM} ${WRAPPER_FILE}

  ${BASE}/gen_vbox_job.sh ${JOB_FILE}
  ${BASE}/gen_version.sh ${VERSION_FILE} \
	${WRAPPER_FILE} \
	${JOB_FILE} \
	${UCVM_FILE} \
	${CACHE_FILE} \
	${CONTEXT_FILE}

  ln ${tmpdir}/${UCVM_FILE} .
  ln ${tmpdir}/${CACHE_FILE} .
  ln ${tmpdir}/${CONTEXT_FILE} .
  popd
done

tar -C ${tmpdir} --hard-dereference -czf ${OUTPUT}/${BBPAAN_TGZ} ${BBPAAN_VERSION}

rm -rf ${tmpdir}
