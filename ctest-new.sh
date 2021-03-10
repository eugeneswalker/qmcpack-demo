#!/bin/bash -ex

export MPICH_CC=clang
export MPICH_CXX=clang++

ctest \
	-DCMAKE_C_CMPICHLER=mpicc \
	-DCMAKE_CXX_CMPICHLER=mpicxx \
	-DQMC_MPI=1 \
	-DQMC_MIXED_PRECISION=0 \
	-DQMC_COMPLEX=0 \
	-DQMC_CUDA=1 \
	-DENABLE_SOA=1 \
	-DENABLE_TIMERS=1 \
	-DBUILD_AFQMC=0 ../CMake/ctest_script.cmake,release \
        -DQMC_OPTIONS='-DENABLE_OFFLOAD=ON;-DUSE_OBJECT_TARGET=ON;-DCUDA_HOST_COMPILER=`which gcc`;-DCUDA_PROPAGATE_HOST_FLAGS=OFF;-DQMC_NIO_MAX_SIZE=16' \
	-DENABLE_CUDA=1 \
        -DCUDA_ARCH=sm_80 \
	--tests-regex deterministic -LE unstable -E long-
