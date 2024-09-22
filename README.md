# docker-novnc

tigervnc, websokify, novnc and Nginx with s6-overlay in a docker image, forked from [oott123/docker-novnc](https://github.com/oott123/docker-novnc).

## Environment variables

* **`VNC_GEOMETRY`** - VNC geometry; default: `800x600`
* **`VNC_PASSWD`** - VNC password, no more than 8 chars; default: `MAX8char`
* **`USER_PASSWD`** - user `user` password. If you specify it, it will change the password for user `user` and add it to sudoers. NOTE: This password can get by programs so it's not safe. default: _(blank)_
* **`HTTP_AUTH_USER`** - Nginx HTTP Basic Authentication Username; default: _(blank)_
* **`HTTP_AUTH_PASSWD`** - Nginx HTTP Basic Authentication Password; default: _(blank)_

## Ports

* **5911** - tigervnc
* **9000** - Nginx
* **9001** - websockify

**Warning: 9001 and 5911 only use VNC_PASSWD for authentication, and it is strongly recommended not to forward these two ports externally most of the time.**

## Docker Images

* **`./Dockerfile.amd64`** - based on Ubuntu18.04 amd64, DockerHub tag `latest`/`latest-amd64`/`amd64`

* **`./Dockerfile.arm64`** - based on Ubuntu18.04 arm64, DockerHub tag `latest-arm64`/`arm64`

* **`./Dockerfile.amd64-2004`** - based on Ubuntu20.04 amd64, DockerHub tag `latest-2004`/`latest-amd64-2004`/`amd64-2004`

* **`./Dockerfile.arm64-2004`** - based on Ubuntu20.04 arm64, DockerHub tag `latest-arm64-2004`/`arm64-2004`

* **`./Dockerfile.amd64-2204`** - based on Ubuntu22.04 amd64, DockerHub tag `latest-2204`/`latest-amd64-2204`/`amd64-2204`

* **`./Dockerfile.arm64-2204`** - based on Ubuntu22.04 arm64, DockerHub tag `latest-arm64-2204`/`arm64-2204`

* **`./Dockerfile.amd64-2404`** - based on Ubuntu24.04 amd64, DockerHub tag `latest-2404`/`latest-amd64-2404`/`amd64-2404`

* **`./Dockerfile.arm64-2404`** - based on Ubuntu24.04 arm64, DockerHub tag `latest-arm64-2404`/`arm64-2404`

## Add your foreground process

`vncmain.sh` is a file which is a placeholder for foreground process running in VNC.

You can write a Dockerfile like this:

```Dockerfile
FROM dockerguiimages/docker-novnc:latest
COPY vncmain.sh /app/vncmain.sh
```

And add foreground commands in your `vncmain.sh`:

```bash
#!/bin/bash
# Set them to empty is NOT SECURE but avoid them display in random logs.
export VNC_PASSWD=''
export USER_PASSWD=''
export HTTP_AUTH_USER=''
export HTTP_AUTH_PASSWD=''

xterm
```

Then build and run your docker image. That's it!
