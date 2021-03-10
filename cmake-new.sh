#!/bin/bash -ex

export MPICH_CC=clang
export MPICH_CXX=clang++
export MPICH_FC=gfortran

cmake \
	-DCMAKE_C_COMPILER=mpicc \
	-DCMAKE_CXX_COMPILER=mpicxx \
	\
	-DQMC_MPI=0 \
	-DQMC_MIXED_PRECISION=0 \
	-DQMC_COMPLEX=0 \
	\
	-DENABLE_SOA=1 \
	-DENABLE_TIMERS=1 \
	-DENABLE_CUDA=1 \
	-DENABLE_OFFLOAD=ON \
	\
	-DCUDA_ARCH=sm_80 \
	-DCUDA_HOST_COMPILER=`which gcc` \
	\
	-DUSE_OBJECT_TARGET=ON \
	-DOFFLOAD_ARCH=sm_80 \
	-DBUILD_AFQMC=0 ..
