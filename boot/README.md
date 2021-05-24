# Boot directory setup

## Directory

This directory holds the files required for boot. The files are added in the `.gitignore` list.

Create kernel and rootfs image files and copy to this directory.
See [here](https://github.com/firecracker-microvm/firecracker/blob/master/docs/rootfs-and-kernel-setup.md) for details.

e.g. `ls` output from my machine

```bash
$ ls -lh
total 2.4G
-rw-r--r--. 1 jostho jostho 1.2G Feb 23 20:52 ubuntu-18-rootfs.ext4
-rw-r--r--. 1 jostho jostho 1.2G Feb 23 20:52 ubuntu-20-rootfs.ext4
-rwxr-xr-x. 1 jostho jostho  35M Feb 22 20:53 vmlinux
```

## Kernel

Build kernel on a `Debian 10` box

```bash
sudo apt-get -y -qq install make gcc flex bison libelf-dev libssl-dev bc
```

Prepare a working directory

```bash
mkdir -p ~/src && cd ~/src
```

Get kernel sources

```bash
curl -LO https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.4.121.tar.xz
```

Get config file from [ignite](https://github.com/weaveworks/ignite) project

```bash
curl -O https://raw.githubusercontent.com/weaveworks/ignite/main/images/kernel/versioned/config-amd64-5.4.108
```

Prepare kernel sources for build

```bash
tar xf ./linux-5.4.121.tar.xz
cp ./config-amd64-5.4.108 ./linux-5.4.121/.config
```

Build the kernel

```bash
cd ~/src/linux-5.4.121 && make vmlinux
```

Copy `vmlinux` file to the `boot/` directory.

## Rootfs

### Ubuntu 18.04

Build ubuntu 18.04 rootfs file from `bionic-server-cloudimg-amd64-root.tar.xz` available [here](http://cloud-images.ubuntu.com/bionic/current/)

### Ubuntu 20.04

Build ubuntu 20.04 rootfs file from `focal-server-cloudimg-amd64-root.tar.xz` available [here](http://cloud-images.ubuntu.com/focal/current/)
