#!/bin/bash

## export NTCL_ROOT=/home/tin/tin-gh/ntcl-build

#sudo apt install environment-modules
#sudo apt install lmod

export NTCL_ROOT=/opt/gitrepo/


test -d ${NTCL_ROOT} || mkdir -p ${NTCL_ROOT}

cd ${NTCL_ROOT}

git clone https://gitlab.com/ntcl/ntcl-algorithms.git     
git clone https://gitlab.com/ntcl/ntcl-tensor.git     
git clone https://gitlab.com/ntcl/ntcl-data.git     
git clone https://gitlab.com/ntcl/ntcl-util.git     
git clone https://gitlab.com/ntcl/ntcl-build.git 
git clone https://gitlab.com/ntcl/ntcl-examples.git 



cd ${NTCL_ROOT}/ntcl-util
make | tee -a make.log
make test | tee -a make_test.log

cd ${NTCL_ROOT}/ntcl-data
make | tee -a make.log
make test | tee -a make_test.log

cd ${NTCL_ROOT}/ntcl-tensor
make | tee -a make.log
make test | tee -a make_test.log

cd ${NTCL_ROOT}/ntcl-algorithms
make | tee -a make.log
make test | tee -a make_test.log


cd ${NTCL_ROOT}/ntcl-build
./bin/ntcl-build.py -h   # sanity check, that it has all required settings and it can at least load
./bin/ntcl-build.py -l  2>&1 | tee ntcl-build.listTest.teeOut.txt  # check list option
#mkdir /scratch
#bin/ntcl-build.py -c -b /scratch/ntcl
# ^^ fails

export CUDADIR=/usr/local/cuda-11
export CUDA_GCC_DIR=/usr/bin
export CUDA_ROOT=$CUDADIR

cd ${NTCL_ROOT}/
./ntcl-build/bin/ntcl-build.py -u                    2>&1 | tee ntcl-build-u.teeOut.txt
#./ntcl-build/bin/ntcl-build.py -c -t -s default.cuda 2>&1 | tee ntcl-build.default.cuda.teeOut.txt
#./ntcl-build/bin/ntcl-build.py -c     -t -s      ws.cuda 2>&1 | tee ntcl-build.ws.cuda.teeOut.txt
cp -p container/default.cuda .
cp -p container/machinefile.cuda .
cp -p container/scan.sh .

./ntcl-build/bin/ntcl-build.py -c -cl -t -f ./default.cuda 2>&1 | tee ntcl-build.default.cuda.teeOut.txt
# ^^ work like this?

ls -l ntcl-examples/bin/timed_mm.x

# run scan.bash script once build is complete, customization maybe required
