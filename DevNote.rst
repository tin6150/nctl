
docker pull ghcr.io/tin6150/ntcl:main
docker tag  ghcr.io/tin6150/ntcl:main registry.greta.local:443/ntcl:main
docker tag  ghcr.io/tin6150/ntcl:main registry.greta.local:443/ntcl:deb1
docker tag  ghcr.io/tin6150/ntcl:main registry.greta.local:443/ntcl:cuda1

docker image push                     registry.greta.local:443/ntcl:main
docker run  --gpus all -it --entrypoint=/bin/bash   registry.greta.local:443/ntcl:main  


# manual build, mostly:
# docker build -f Dockerfile .  | tee LOG.Dockerfile.txt
# docker build -t registry.greta.local:443/ntcl:d1 -f Dockerfile .  | tee LOG.Dockerfile.deb1.txt

docker run -it registry.greta.local:443/ntcl:d3

~~~~~

c02:
docker run -it registry.greta.local:443/ntcl:cuda1
 run 
ntcl-build/bin/ntcl-build.py -c -cl -t 
just to make sure that everything works without gpu's.


docker run -it -v ~tin/tin-gh/ntcl:/mnt ghcr.io/tin6150/nctl:main


c02> 
docker run -it -v ~tin/tin-gh/ntcl:/mnt registry.greta.local:443/ntcl:cuda1

export CUDA_GCC_DIR=/usr/bin
export CUDADIR=/usr/local/cuda-11
ntcl-build/bin/ntcl-build.py -c -cl -t -f /mnt/default.cuda

~~~~~

Running 'make libraries' in /opt/gitrepo/ntcl-util
Command script:
cd /opt/gitrepo/ntcl-util
module load gcc openblas cuda


export use_blas="1"
export use_cuda="1"
export use_cublas="1"
make libraries

Running 'make libraries' in /opt/gitrepo/ntcl-data
Command script:
cd /opt/gitrepo/ntcl-data
module load gcc openblas cuda
export system="gcc"
export modules="gcc openblas cuda"
export compiler_suite="gcc"
export use_blas="1"
export use_cuda="1"
export use_cublas="1"
make libraries

Traceback (most recent call last):
  File "./ntcl-build/bin/ntcl-build.py", line 228, in <module>
    if args.compile: prepare_and_compile_code(args)
  File "./ntcl-build/bin/ntcl-build.py", line 197, in prepare_and_compile_code
    run_make_in_all_dirs(dirs, env, "libraries", args.dryrun)
  File "./ntcl-build/bin/ntcl-build.py", line 180, in run_make_in_all_dirs
    for d in dirs: run_make(d, env, target, dryrun)
  File "./ntcl-build/bin/ntcl-build.py", line 177, in run_make
    subprocess.run(cmd, shell=True, executable='/bin/bash', env=env.build_env, check=True)
  File "/usr/lib/python3.8/subprocess.py", line 516, in run
    raise CalledProcessError(retcode, process.args,
subprocess.CalledProcessError: Command 'cd /opt/gitrepo/ntcl-data
module load gcc openblas cuda
export system="gcc"
export modules="gcc openblas cuda"
export compiler_suite="gcc"
export use_blas="1"
export use_cuda="1"
export use_cublas="1"
make libraries
' returned non-zero exit status 2.

