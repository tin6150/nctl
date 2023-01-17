#!/bin/bash

## export NTCL_ROOT=/home/tin/tin-gh/ntcl-build

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

cd ${NTCL_ROOT}/
./ntcl-build/bin/ntcl-build.py -c -t -s default.cuda 2>&1 | tee ntcl-build.teeOut.txt
# ^^ work like this?

