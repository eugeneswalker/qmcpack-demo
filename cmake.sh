#!/bin/bash -ex

export MPICH_CC=clang
export MPICH_CXX=clang++

cmake \
	-DCMAKE_C_COMPILER=mpicc \
	-DCMAKE_CXX_COMPILER=mpicxx \
	-DQMC_MPI=1 \
	-DQMC_MIXED_PRECISION=0 \
	-DQMC_COMPLEX=0 \
	-DENABLE_SOA=1 \
	-DENABLE_TIMERS=1 \
	-DBUILD_AFQMC=0 ..

