# Kernel-Build

This repository contains a Docker image to compile the Linux kernel for Android devices.

> All dependencies on the image will remain up to date as build workflow runs every day at 10:00 UTC.

## Pulling the Docker image

The kernel-build Docker image can be pulled from both ghcr.io and Docker Hub.

### GitHub Container Registry (`ghcr.io`):

```sh
docker pull ghcr.io/rabilrbl/kernel-build:latest
```

### Docker Hub:

```sh
docker pull rabilrbl/kernel-build:latest
```

## Building the Docker image

The kernel-build Docker image can be built from the Dockerfile in this repository.

```sh
docker build -t kernel-build .
```
All build arguments specified below are optional. 

### Build arguments
- `GIT_NAME`: Name to use for git commits. Default: `KernelB`
- `GIT_EMAIL`: Email to use for git commits. Default: `20230226+kernelb@users.noreply.github.com`
- `PULL_REBASE`: Perform rebase instead of merge when pulling. Default: `true`

You can pass build arguments to the build command like this:

```sh
docker build -t kernel-build --build-arg GIT_NAME="John Doe" --build-arg GIT_EMAIL="john@doe.com" .
```
## Tags

The kernel-build Docker image is tagged with all available branches in this repository. The `latest` tag is the default branch.

### Using a specific tag or branch

```sh
docker pull ghcr.io/rabilrbl/kernel-build:main
```

---

Please note that the Docker image is built on top of the [Ubuntu latest](https://hub.docker.com/_/ubuntu) image.