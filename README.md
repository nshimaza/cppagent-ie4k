# MTConnect Agent on IE4000 IOx

This Git repo provides procedure and Dockerfiles to build an IOx application
running open source C++ MTConnect Agent on Cisco Industrial Ethernet 4000 Series
Switches.  This demonstrates how you can build and package IOx apps for IE4000.

With this procedure, using Cisco provided Docker image from
[devhub-docker.cisco.com](devhub-docker.cisco.com) is vital.  The image contains
PowerPC binaries and executed under QEMU emulated environment so that you can
run the binaries in the docker image as if they are x86 native binaries.  This
simplifies build and test environment where you can compile and run PowerPC code
within Docker.

Building process consists of following steps.

1. Build MTConnect Agent executable using Cisco provided Docker image.
1. Extract the built executable from the image.
1. Build Docker image for runtime.
1. Convert the runtime image to IOx application.

## Prepare your environment

Before you start, you need to have `ioxclient` installed.

`ioxclient` is a developer tool used for manipulating IOx environment.
It will be used for creating IOx application from a Docker image.
You can download `ioxclient` from
[DevNet IOx resource download page](https://developer.cisco.com/docs/iox/#!iox-resource-downloads).

Cisco provides Docker image tailored for IOx application.  It can be used both
for build environment and runtime environment.  The image is distributed via
[devhub.cisco.com](devhub.cisco.com).

Consult to
[Cisco DevNet site](https://developer.cisco.com/docs/iox/#!docker-images-and-packages-repository/overview)
for more detail.

## Build runtime Docker image

The `Dockerfile` under `runtime` folder builds `cppagent` binary and Docker
image for runtime for you.  Execute following commands.

```shell-session
$ cd runtime
$ sudo docker build -t cppagent-ie4k .
```

The Dockerfile under `runtime` is a multi-stage Dockerfile.  The first stage
pulls all dependency for building `cppagent` and compile it.  The second stage
copies the `cppagent` binary from the first image then setup dependency only
necessary for runtime.

You will get a Docker image tagged with "cppagent-ie4k".  The image contains
agent executable and start-up shell script.  The agent executable is located
at `/usr/local/bin/agent`.  Startup shell script is located at
`user/local/bin/start_agent.sh`.  `start_agent.sh` can be a startup script for
IOx app.

## Convert Docker image to IOx app

Once a Docker image for runtime has been built, you can convert it to
IOx application package.

Navigate to the directory `app` and execute following command.

```shell-session
$ cd ../app
$ sudo ioxclient docker package cppagent-ie4k .
```

You will get `packaget.tar` which is IOx application package installable to
IE-4000.

## Build environment

`Dockerfile` under `build` folder creates a build environment for `cppagent`.
It pulls source Docker image for IOx app and all dependencies for building
`cppagent` then compile it.  You can leverage this environment for developing
your own version of `cppagent` IOx app.

You don't have to create this image just to get runtime image.  `Dockerfile`
under `runtime` folder does it for you automatically.
