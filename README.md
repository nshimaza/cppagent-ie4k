# MTConnect Agent on IE4000 IOx

This Git repo provides procedure and Dockerfiles to build an IOx
application running open source C++ MTConnect Agent on
Cisco Industrial Ethernet 4000 Series Switches.

Building process consists of following steps.

1. Build MTConnect Agent executable using Cisco provided Docker image.
1. Extract the built executable from the image.
1. Build Docker image for runtime.
1. Convert the runtime image to IOx application.

## Prepare your environment

Before you start, you need to perform two steps bellow.

* Install `ioxclient`
* Let Docker login to [github.cisco.com](github.cisco.com).

`ioxclient` is a developer tool used for manipulating IOx environment.
It will be used for creating IOx application from a Docker image.

Cisco provides Docker image tailored for IOx application.  It can be used both
for build environment and runtime environment.  The image is distributed via [github.cisco.com](github.cisco.com).  You need to let your
Docker logged in to the side with following command so that you can obtain
the image during `docker build` process.

```shell-session
$ docker login -u iox_docker.gen -p AKCp2WX2yZXhwiQXG2xZjHvnrov8HA2HkXZyH3Z46ErGNMDz1fHQKAMRCBbEvseLowd7BQ8S1 devhub-docker.cisco.com
```

Consult to [Cisco DevNet site](https://developer.cisco.com/site/iox/docs/#docker-images-and-packages-repository) for more detail.

## Build executable in Docker image

Build MTConnect Agent executable using Docker image from Cisco.
The Dockerfile under build directory does it for you.
Execute following command.

```shell-session
$ cd build
$ docker build -t cppagent-ie4k-build .
```

You will get a Docker image tagged with "cpp-agent-ie4k-build".

## Extract executable from the image

The executable is built at /opt/src/cppagent/agent/agent.
You can extract it by executing following command.

```shell-session
$ cd ../runtime
$ docker run --rm -ti --volume "`pwd`:/vol" cppagent-ie4k-build /bin/sh /copy.sh
```

You will get 32-bit PowerPC executable file named "agent" on your working directory.

## Build runtime Docker image

Make sure you already have a 32-bit PowerPC executable file named "agent" under runtime directory.

The Dockerfile under the runtime directory builds a Docker image which
contains the "agent" executable and necessary dynamic libraries for you.
To get the image, execute following command under runtime directory.

```shell-session
$ docker build -t cppagent-ie4k .
```

You will get a Docker image tagged with "cppagent-ie4k".
The image contains agent executable and start-up shell script.

## Convert Docker image to IOx app

Once a Docker image for runtime has been built, you can convert it to
IOx application package.

Navigate to the directory `app` and execute following command.

```shell-session
$ cd ../app
$ ioxclient docker package cppagent-ie4k .
```

You will get `packaget.tar` which is IOx application package installable to IE-4000.
