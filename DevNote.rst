
docker pull ghcr.io/tin6150/nctl:main


# manual build, mostly:
# docker build -f Dockerfile .  | tee LOG.Dockerfile.txt
# docker build -t registry.greta.local:443/ntcl:d1 -f Dockerfile .  | tee LOG.Dockerfile.deb1.txt

docker run -it registry.greta.local:443/ntcl:d3

