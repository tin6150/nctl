# Dockerfile for creating container to host nctl -- for gpu benchmark on greta


## FROM debian:bullseye ## vanilla container, no CUDA
## FROM nvidia/cuda:11.7.1-devel-ubuntu22.04  # hung A5000 with cuda 11.4/centos 7.9 (b15)
## FROM nvidia/cuda:11.2.1-devel-ubuntu18.04  # n0005 CUDA 11.2 >>  wrong opencl-icd
## FROM nvidia/cuda:11.4.2-devel-ubuntu18.04  # n0259 CUDA 11.4
FROM nvidia/cuda:11.4.2-devel-ubuntu20.04
#?? FROM nvidia/cuda:11.4.0-devel-centos7
# default aka :latest no longer supported.  https://hub.docker.com/r/nvidia/cuda

LABEL Ref="https://gitlab.com/ntcl/ntcl"
LABEL Ref="https://github.com/tin6150/nctl/"

MAINTAINER Tin_at_berkeley.edu
ARG DEBIAN_FRONTEND=noninteractive
#ARG TERM=vt100
ARG TERM=dumb
ARG TZ=PST8PDT
#https://no-color.org/
ARG NO_COLOR=1


# will use stand alone script to do most of the installation
# so that it can be used on singlarity (if not building from docker image)
# or perhaps installed on a cloud instance directly

RUN echo  ''  ;\
    touch _TOP_DIR_OF_CONTAINER_  ;\
    echo "This container build as os, then add additional package via standalone shell script " | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    export TERM=dumb      ;\
    export NO_COLOR=TRUE  ;\
    apt-get update ;\
    apt-get -y --quiet install apt-utils ;\
    apt-get -y --quiet install git  file wget curl gzip bash zsh fish tcsh less vim procps screen tmux ;\
    apt-get -y --quiet install git-all git-el ;\
    apt-get -y --quiet install python3 python-git-doc python-gitlab-doc ;\
    apt-get -y --quiet install apt-file ;\
    dpkg --list | tee -a dpkg--list.out ;\
    cd /    ;\
    echo ""

RUN echo ''  ;\
    echo '==================================================================' ;\
    test -d /opt/gitrepo            || mkdir -p /opt/gitrepo             ;\
    test -d /opt/gitrepo/container  || mkdir -p /opt/gitrepo/container   ;\
    #the git command dont produce output, thought container run on the dir squatting on the git files.  COPY works... oh well
    #git branch |tee /opt/gitrepo/container/git.branch.out.txt            ;\
    git log --oneline --graph --decorate | tee /opt/gitrepo/container/git.lol.out.txt       ;\
    #--echo "--------" | tee -a _TOP_DIR_OF_CONTAINER_           ;\
    #--echo "git cloning the repo for reference/tracking" | tee -a _TOP_DIR_OF_CONTAINER_ ;\
    cd /     ;\
    echo ""

# add some marker of how Docker was build.
COPY .              /opt/gitrepo/container/


# clone other companion ntcl repos 
RUN echo  ''  ;\
    touch _TOP_DIR_OF_CONTAINER_  ;\
    echo "stage flag -- clone companion ntcl repos" | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    date | tee -a       _TOP_DIR_OF_CONTAINER_ ;\
    export TERM=dumb      ;\
    export NO_COLOR=TRUE  ;\
    echo ""  ;\
    cd /opt/gitrepo     ;\
    git clone https://gitlab.com/ntcl/ntcl-build.git     ;\
    echo "$?" | tee -a clone.nctl-build.status.out ;\
    git clone https://gitlab.com/ntcl/ntcl-examples.git     ;\
    echo "$?" | tee -a clone.nctl-examples.status.out ;\
    cd /     ;\
    echo ""  


RUN echo  ''  ;\
    touch _TOP_DIR_OF_CONTAINER_  ;\
    echo "begining docker build process at " | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    date | tee -a       _TOP_DIR_OF_CONTAINER_ ;\
    export TERM=dumb      ;\
    export NO_COLOR=TRUE  ;\
    cd /     ;\
    echo ""  ;\
    echo '==================================================================' ;\
    echo '==== install beagle gpu lib ===================== SKIP ===========' ;\
    echo '==================================================================' ;\
    echo " calling external shell script..." | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    date | tee -a      _TOP_DIR_OF_CONTAINER_                                 ;\
    echo '==================================================================' ;\
    cd /opt/gitrepo/nctl-build     ;\
    git branch |tee ./git.branch.out.txt                 ;\
    bin/ntcl-build.py -c  2>&1 | tee nctl-build.teeOut.log ;\
    cd /    ;\
    echo ""

ENV DBG_CONTAINER_VER  "Dockerfile 2023.0113 draft1"
ENV DBG_DOCKERFILE Dockerfile


RUN  cd / \
  && touch _TOP_DIR_OF_CONTAINER_  \
  && echo  "--------" >> _TOP_DIR_OF_CONTAINER_   \
  && TZ=PST8PDT date  >> _TOP_DIR_OF_CONTAINER_   \
  && echo  $DBG_CONTAINER_VER   >> _TOP_DIR_OF_CONTAINER_   \
  && echo  "Grand Finale for Dockerfile"


ENV TZ America/Los_Angeles
# ENV TZ likely changed/overwritten by container's /etc/csh.cshrc



# https://docs.docker.com/engine/reference/builder/#understand-how-cmd-and-entrypoint-interact
ENTRYPOINT [ "/bin/bash" ]

# vim: shiftwidth=4 tabstop=4 formatoptions-=cro nolist nu syntax=on
