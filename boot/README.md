# Boot directory setup

## Directory

This directory holds the files required for boot. The files are added in the `.gitignore` list.

Create kernel and rootfs image files and copy to this directory.
See [here](https://github.com/firecracker-microvm/firecracker/blob/master/docs/rootfs-and-kernel-setup.md) for details.

e.g. `ls` output from my machine

```bash
$ ls -lh boot/
total 2.1G
-rw-r--r--. 1 jose jose 1.7K Jul  7 12:09 README.md
-rw-r--r--. 1 jose jose 1.2G Jul  7 12:12 ubuntu-20-rootfs.ext4
-rw-r--r--. 1 jose jose 1.2G Jul  7 12:12 ubuntu-22-rootfs.ext4
-rwxr-xr-x. 1 jose jose  42M Jul  7 11:13 vmlinux
```

## Kernel

Build kernel on a `Ubuntu 22.04` box

```bash
sudo apt-get -y -qq install make gcc flex bison libelf-dev libssl-dev bc
```

Prepare a working directory

```bash
mkdir -p ~/src && cd ~/src
```

Get kernel sources

```bash
curl -LO https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.10.128.tar.xz
```

Get config file from [ignite](https://github.com/weaveworks/ignite) project

```bash
curl -O https://raw.githubusercontent.com/weaveworks/ignite/main/images/kernel/generated/config-amd64-5.10.77
```

Prepare kernel sources for build

```bash
tar xf ./linux-5.10.128.tar.xz
cp ./config-amd64-5.10.77 ./linux-5.10.128/.config
```

Build the kernel

```bash
cd ~/src/linux-5.10.128 && make vmlinux
```

Copy `vmlinux` file to the `boot/` directory.

## Rootfs

### Ubuntu 20.04

Build ubuntu 20.04 rootfs file from `focal-server-cloudimg-amd64-root.tar.xz` available [here](http://cloud-images.ubuntu.com/focal/current/)

### Ubuntu 22.04

Build ubuntu 22.04 rootfs file from `jammy-server-cloudimg-amd64-root.tar.xz` available [here](http://cloud-images.ubuntu.com/jammy/current/)
