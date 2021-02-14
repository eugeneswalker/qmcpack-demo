#!/bin/bash -ex

export MPICH_CC=clang
export MPICH_CXX=clang++

ctest \
	-DCMAKE_C_CMPICHLER=mpicc \
	-DCMAKE_CXX_CMPICHLER=mpicxx \
	-DQMC_MPI=1 \
	-DQMC_MIXED_PRECISION=0 \
	-DQMC_COMPLEX=0 \
	-DENABLE_SOA=1 \
	-DENABLE_TIMERS=1 \
	-DBUILD_AFQMC=0 ../CMake/ctest_script.cmake,release \
	--tests-regex deterministic -LE unstable -E long-
