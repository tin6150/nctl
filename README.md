# Nuclear Tensor Contraction Library (NTCL)

## Introduction
NTCL is a domain-specific numerical library that presents a tensor contraction API to fortran. It is plugin based and supports multiple hardware architectures like NVIDIA and AMD GPU's as well as regular CPU's. In its simplest form, NTCL have very few dependencies, but it can utilize other libraries like cublas, magma, rocmblas, and cuTENSOR if they are available.

NTCL is spread over multiple repositories. First, [ntcl-util](https://gitlab.com/ntcl/ntcl-util/) contains a set of general-purpose utility classes. Second, [ntcl-data](https://gitlab.com/ntcl/ntcl-data/) implements the mechanisms for dealing with multiple architectures like memory and concurrency. Third, [ntcl-tensor](https://gitlab.com/ntcl/ntcl-tensor/) implements the tensor datastructures, as well as interfaces to convert between ntcl data structures and fortran arrays and data types. Last, [ntcl-algorithms](https://gitlab.com/ntcl/ntcl-algorithms/) contains the main entry-point for using the algorithms presented by the library, namely a tensor contraction and a batched tensor contraction. Each algorithm has a number of implementations, each with its own parameters that can be specified at runtime. In addition [ntcl-examples](https://gitlab.com/ntcl/ntcl-examples/) contains a number of examples on how to use the library in. Notably, the ccsd example implements the coupled-cluster singles- and doubles method used to solve the Schrödinger equation for many interacting fermions.

## Building
Each repository can be built independently, but [ntcl-build](https://gitlab.com/ntcl/ntcl-build/) provides scripts to simplify the build process. See the README for additional details on building this library.

## Applications
By default, NTCL provides libraries for static linking. See the Makefile in [ntcl-examples](https://gitlab.com/ntcl/ntcl-examples/) for the proper link line to use the library and for example applications.
