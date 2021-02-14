#!/bin/bash -e

#SPACK_REF=9d8b8553f1ad95f26be2a03fbf94c1fdec257792
SPACK_REF=851490bd5424f327edbde44d6d78a9cfe867df9a # 2-13-2021
QMCPACK_REF=develop

if [ ! -d spack ] ; then
  echo Cloning Spack
  git clone https://github.com/spack/spack
else
  echo Spack cloned
fi

echo Checking out Spack commit ${SPACK_REF}
(cd spack && git checkout ${SPACK_REF})

. spack/share/spack/setup-env.sh

echo Configuring Spack to use E4S Build Cache
spack mirror rm E4S >/dev/null 2>&1 || :
spack mirror add E4S https://cache.e4s.io/qmcpack
[ ! -f e4s.pub ] && wget https://oaciss.uoregon.edu/e4s/e4s.pub
spack gpg trust e4s.pub

cp spack-llvm.yaml spack.yaml
spack -e . concretize -f | tee llvm.dag
time spack -e . install --cache-only

GCC_BIN=$(dirname $(which gcc)) ; export GCC_BIN
LLVM_ROOT=$(spack location -i llvm) ; export LLVM_ROOT
envsubst < compilers.yaml.tpl > ~/.spack/linux/compilers.yaml

spack compiler find

cp spack-qmcpack.yaml spack.yaml
spack -e . concretize -f | tee qmcpack.dag

time spack -e . install \
	--cache-only \
	--include-build-deps

if [ ! -d qmcpack ] ; then
  echo Cloning QMCPACK
  git clone https://github.com/QMCPACK/qmcpack.git
else
  echo QMCPACK is cloned
fi

(cd qmcpack && git checkout ${QMCPACK_REF})

mkdir -p qmcpack/build-test
cp ctest.sh cmake.sh qmcpack/build-test
cp cmake.sh qmcpack/build-test/
cd qmcpack/build-test
spack load llvm
spack load cmake
spack load --only dependencies qmcpack
./cmake.sh
make -j16
./ctest.sh

