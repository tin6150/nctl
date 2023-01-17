
docker pull ghcr.io/tin6150/ntcl:main
docker tag  ghcr.io/tin6150/ntcl:main registry.greta.local:443/ntcl:main
docker tag  ghcr.io/tin6150/ntcl:main registry.greta.local:443/ntcl:deb1
docker image push                     registry.greta.local:443/ntcl:main
docker run  --gpus all -it --entrypoint=/bin/bash   registry.greta.local:443/ntcl:main  


# manual build, mostly:
# docker build -f Dockerfile .  | tee LOG.Dockerfile.txt
# docker build -t registry.greta.local:443/ntcl:d1 -f Dockerfile .  | tee LOG.Dockerfile.deb1.txt

docker run -it registry.greta.local:443/ntcl:d3

