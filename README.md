# Multi-arch capable hugo container

docker image for [hugo](https://gohugo.io/) based off of alpine:latest

To pull this image:

```bash
docker pull m5p3nc3r/hugo
```

Example usage:

```bash
docker run -it --rm m5p3nc3r/hugo --help
```

## Run server for development

```bash
docker run -it --rm \
  -u "$(id -u):$(id -g)" \
  -p 1313:1313 \
  -w "${PWD}" \
  -v "${PWD}":"${PWD}" \
  m5p3nc3r/hugo server \
  --bind 0.0.0.0
```

## Build site

```bash
docker run -it --rm \
  -u "$(id -u):$(id -g)" \
  -w "${PWD}" \
  -v "${PWD}":"${PWD}" \
  m5p3nc3r/hugo \
  -v
```

Make sure to run the above commands with the `-u` and `-g` parameters otherwise you may end up with files that have been written as `root:root`

## Develoment

This project was forked from [mbentley's](https://github.com/mbentley/docker-hugo) work by adding multi architecture build via docker buildx.

To build this project, I use the following

```bash
# Add --push to automatically push to hub.docker.com
docker buildx build -t m5p3nc3r/hugo --platform linux/amd64,linux/arm64 .
```
