#!/bin/bash

## export NTCL_ROOT=/home/tin/tin-gh/ntcl-build

export NTCL_ROOT=/opt/gitrepo/


test -d ${NTCL_ROOT} || mkdir -p ${NTCL_ROOT}

cd ${NTCL_ROOT}

git clone https://gitlab.com/ntcl/ntcl-util.git     
git clone https://gitlab.com/ntcl/ntcl-data.git     
git clone https://gitlab.com/ntcl/ntcl-tensor.git     
git clone https://gitlab.com/ntcl/ntcl-algorithms.git     
git clone https://gitlab.com/ntcl/ntcl-build.git 
git clone https://gitlab.com/ntcl/ntcl-examples.git 



cd ${NTCL_ROOT}/ntcl-util
make | tee -a make.log

${NTCL_ROOT}/ntcl-data
make | tee -a make.log

${NTCL_ROOT}/ntcl-tensor
make | tee -a make.log

${NTCL_ROOT}/ntcl-algorithms
make | tee -a make.log
