#!/bin/bash -ex

ctest \
	-DCMAKE_C_COMPILER=clang \
	-DCMAKE_CXX_COMPILER=clang++ \
	-DCMAKE_CXX_FLAGS="-stdlib=libstdc++" \
	\
	-DQMC_MPI=0 \
	-DQMC_MIXED_PRECISION=0 \
	-DQMC_COMPLEX=0 \
        -DQMC_OPTIONS='-DENABLE_OFFLOAD=ON;-DUSE_OBJECT_TARGET=ON;-DCUDA_HOST_COMPILER=`which gcc`;-DCUDA_PROPAGATE_HOST_FLAGS=OFF;-DQMC_NIO_MAX_SIZE=16' \
	\
	-DENABLE_CUDA=1 \
	-DENABLE_OFFLOAD=ON \
	-DENABLE_TIMERS=1 \
	\
	-DCUDA_ARCH=sm_80 \
	-DCUDA_HOST_COMPILER=`which gcc` \
	\
	-DUSE_OBJECT_TARGET=ON \
	-DOFFLOAD_ARCH=sm_80 \
	\
	-DBUILD_AFQMC=0 \
	\
	-L deterministic \
	-LE unstable \
	-E long \
	..

#	-S ../CMake/ctest_script.cmake,release \
#	-VV \