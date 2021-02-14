compilers:
- compiler:
    spec: clang@11.0.1
    paths:
      cc: ${LLVM_ROOT}/bin/clang
      cxx: ${LLVM_ROOT}/bin/clang++
      f77: ${GCC_BIN}/gfortran
      fc: ${GCC_BIN}/gfortran
    flags:
      cflags: "-fPIC"
      cxxflags: "-fPIC"
      fflags: "-fPIC"
    operating_system: ubuntu20.04
    target: x86_64
    modules: []
    environment: {}
    extra_rpaths: []
