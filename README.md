# fIcy local Docker

This repo contains a Dockerfile and script to build and run a container with fIcy that will record a stream and output the recording, indefinitely.

The Dockerfile

- updates pkgs and downloads make build tools and wget
- downloads the [latest fIcy tar](https://www.thregr.org/~wavexx/software/fIcy/releases/fIcy-1.0.21.tar.gz)
  - unzips
  - renames directory to ./fIcy
- Copy contents of ./fIcy directory and keep_running.sh to /fIcy/
- Make script executable
- Set ENV var default values for my local setup
- compile fIcy
- run the shell script with environment variables as input args


The shell script does the following:

- run fIcy with parameters
- sleep for 30 seconds
- loop

## Building

To build, run the following from the root of this repo

```
docker build --tag ficy-local .
```

If you're debugging and dont want to wait for the apt update you could build an image with this dockerfile and use that:
```
FROM ubuntu
RUN apt update && apt install -y make build-essential
```
```
docker build -f dockerfile-build . -t ubuntu-build
```

## Usage

Most important thing is to mount your directory for the recordings with `-v <LOCAL_RECORDINGS_DIRECTORY>:/recordings/`

Run the container as a background service, and remove itself when stopped.

```
docker run --rm -d --name "ficy-local" -v /home/user/jrdn/fIcy/recordings/:/recordings/ ficy-local
```