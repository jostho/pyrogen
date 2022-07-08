# Boot directory setup

## Directory

This directory holds the files required for boot. The files are added in the `.gitignore` list.

Build kernel and rootfs image files and copy to this directory.
See [here](https://github.com/firecracker-microvm/firecracker/blob/master/docs/rootfs-and-kernel-setup.md) for details.

e.g. `ls` output from my machine

```bash
$ ls -lh boot/
total 2.1G
-rw-r--r--. 1 jose jose 1.4K Jul  7 14:49 Makefile
-rw-r--r--. 1 jose jose 1.1K Jul  7 15:16 README.md
-rw-r--r--. 1 jose jose 1.2G Jul  7 12:12 ubuntu-20-rootfs.ext4
-rw-r--r--. 1 jose jose 1.2G Jul  7 12:12 ubuntu-22-rootfs.ext4
-rwxr-xr-x. 1 jose jose  42M Jul  7 11:13 vmlinux
```

## Kernel

Build kernel on a `Ubuntu 22.04` host using the `Makefile`

```bash
make vmlinux
```

Copy `vmlinux` file from `Ubuntu 22.04` host to the `boot/` directory.

## Rootfs

### Ubuntu 20.04

Build ubuntu 20.04 rootfs file from `focal-server-cloudimg-amd64-root.tar.xz` available [here](http://cloud-images.ubuntu.com/focal/current/)

### Ubuntu 22.04

Build ubuntu 22.04 rootfs file from `jammy-server-cloudimg-amd64-root.tar.xz` available [here](http://cloud-images.ubuntu.com/jammy/current/)
