# Dockerfile for creating container to host various phylogenic tools 
# manual build, mostly:
# docker build -f Dockerfile .  | tee LOG.Dockerfile.txt
# see DevNotes.rst for more build details


#### still just Dockerfile from phylotool, testing git write access...


## FROM debian:bullseye ## used by r* for OS package without beagle lib for gpu
## FROM nvidia/cuda:11.7.1-devel-ubuntu22.04  # hung A5000 with cuda 11.4/centos 7.9 (b15)
## FROM nvidia/cuda:11.2.1-devel-ubuntu18.04  # n0005 CUDA 11.2 >>  wrong opencl-icd
## FROM nvidia/cuda:11.4.2-devel-ubuntu18.04  # n0259 CUDA 11.4
FROM nvidia/cuda:11.4.2-devel-ubuntu20.04
#?? FROM nvidia/cuda:11.4.0-devel-centos7
# default aka :latest no longer supported.  https://hub.docker.com/r/nvidia/cuda

LABEL Ref="https://github.com/tin6150/beast/"

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
    apt-get -y --quiet install git git-all file wget curl gzip bash zsh fish tcsh less vim procps screen tmux ;\
    apt-get -y --quiet install apt-file ;\
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
#COPY Dockerfile*   /opt/gitrepo/container/


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
    echo " cd to /opt/gitrepo/container/"    | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    date | tee -a      _TOP_DIR_OF_CONTAINER_                                 ;\
    echo '==================================================================' ;\
    cd /opt/gitrepo/container     ;\
    git branch |tee /opt/gitrepo/container/git.branch.out.txt                 ;\
    # the install from source repo create dir, so cd /opt/gitrepo             ;\
    cd /opt/gitrepo                                                           ;\
    #ln -s /opt/gitrepo/container/install_beagle_src.sh .                      ;\
    #bash -x install_beagle_src.sh 2>&1 | tee install_beagle_src.log           ;\
    echo skipped beagle-lib install from source     ;\
    cd /    ;\
    echo ""

RUN  cd / \
  && touch _TOP_DIR_OF_CONTAINER_  \
  && echo  "--------" >> _TOP_DIR_OF_CONTAINER_   \
  && echo  "Dockerfile 2022.1023"   >> _TOP_DIR_OF_CONTAINER_   \
  && echo  "trigger flag to clear cache"

RUN echo  ''  ;\
    touch _TOP_DIR_OF_CONTAINER_  ;\
    echo "begining docker build process at " | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    date | tee -a       _TOP_DIR_OF_CONTAINER_ ;\
    export TERM=dumb      ;\
    export NO_COLOR=TRUE  ;\
    cd /     ;\
    echo ""  ;\
    echo '==================================================================' ;\
    echo '==== install beast phylo sw ======================================' ;\
    echo '==================================================================' ;\
    echo " calling external shell script..." | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    echo " cd to /opt/gitrepo/container/"    | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    date | tee -a      _TOP_DIR_OF_CONTAINER_                                 ;\
    echo '==================================================================' ;\
    cd /opt/gitrepo/container     ;\
    # the install from source repo create dir, so cd /opt/gitrepo             ;\
    cd /opt/gitrepo                                                           ;\
    ln -s /opt/gitrepo/container/install_phylo_tool.sh .                      ;\
    bash -x install_phylo_tool.sh  2>&1 | tee install_phylo_tool.log          ;\
    cd /    ;\
    echo ""



RUN  cd / \
  && touch _TOP_DIR_OF_CONTAINER_  \
  && echo  "--------" >> _TOP_DIR_OF_CONTAINER_   \
  && TZ=PST8PDT date  >> _TOP_DIR_OF_CONTAINER_   \
  && echo  "Dockerfile 2022.1023 b39:libsquizz"   >> _TOP_DIR_OF_CONTAINER_   \
  && echo  "Grand Finale for Dockerfile"

ENV DBG_CONTAINER_VER  "Dockerfile 2022.1023 b39:libsquizz"
ENV DBG_DOCKERFILE Dockerfile

ENV TZ America/Los_Angeles
# ENV TZ likely changed/overwritten by container's /etc/csh.cshrc
# ENV does overwrite parent def of ENV, so can rewrite them as fit.
ENV TEST_DOCKER_ENV     this_env_will_be_avail_when_container_is_run_or_exec
ENV TEST_DOCKER_ENV_2   Can_use_ADD_to_make_ENV_avail_in_build_process
ENV TEST_DOCKER_ENV_REF https://vsupalov.com/docker-arg-env-variable-guide/#setting-env-values

ENV TEST_DOCKER_ENV_YEQ1="Dockerfile ENV assignment as foo=bar, yes use of ="
ENV TEST_DOCKER_ENV_NEQ1 "Dockerfile ENV assignment as foo bar, no  use of =, both seems to work"

# unsure how to append/add to PATH?  likely have to manually rewrite the whole ENV var
#ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/conda/bin
# above is PATH in :integrationU where R 4.1.1 on Debian 11  works on Ubuntu 16.04 path
# below PATH doesn't help resolve Rscript /main.R not finding R problem, but it should not hurt.
#-- ENV PATH=/usr/lib/R/bin/exec:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#-- unset path to ensure it didn't make Rscript behave worse cuz somehow "test" got masked/lost

# /usr/local/lib is searched by beagle, no need to set it
#ENV LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64:/.singularity.d/libs:/usr/local/lib

ENV JAVA_HOME=/usr/bin
#CMD /usr/bin/java -Dlauncher.wait.for.exit=true -Xms256m -Xmx8g -Duser.language=en -cp /opt/gitrepo/beast/lib/launcher.jar beast.app.beastapp.BeastLauncher $*
#CMD /opt/gitrepo/beast/bin/beast 
# https://docs.docker.com/engine/reference/builder/#understand-how-cmd-and-entrypoint-interact

# $@ should be passed by docker run as arg when ENTRYPOINT is invoked
# ref https://stackoverflow.com/questions/32727594/how-to-pass-arguments-to-shell-script-through-docker-run
#ENTRYPOINT /opt/gitrepo/beast/bin/beast $*    # untested
#ENTRYPOINT [ "/opt/gitrepo/beast/bin/beast" ]
#ENTRYPOINT [ "/usr/bin/mb" ]
ENTRYPOINT [ "/bin/bash" ]
#ENTRYPOINT [ "Rscript", "/opt/gitrepo/atlas/main.R" ]
#ENTRYPOINT [ "Rscript", "/main.R" ]

# vim: shiftwidth=4 tabstop=4 formatoptions-=cro nolist nu syntax=on
