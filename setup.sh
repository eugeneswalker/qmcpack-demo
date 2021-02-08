#!/bin/bash -e

SPACK_REF=9d8b8553f1ad95f26be2a03fbf94c1fdec257792

if [ ! -d spack ] ; then
  echo Cloning Spack@${SPACK_REF}
  git clone https://github.com/spack/spack
  (cd spack && git checkout ${SPACK_REF})
else
  echo Spack cloned
fi

. spack/share/spack/setup-env.sh

echo Configuring Spack to use E4S Build Cache
spack mirror rm E4S >/dev/null 2>&1 || :
spack mirror add E4S https://cache.e4s.io
[ ! -f e4s.pub ] && wget https://oaciss.uoregon.edu/e4s/e4s.pub
spack gpg trust e4s.pub

spack -e . concretize -f | tee qmcpack.dag

time spack -e . install --cache-only
