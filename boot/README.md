# Boot directory setup

## Directory

This directory holds the files required for boot. The files are added in the `.gitignore` list.

Create custom rootfs and kernel image files and copy to this directory.
See [here](https://github.com/firecracker-microvm/firecracker/blob/master/docs/rootfs-and-kernel-setup.md) for details.

e.g. `ls` output from my machine

```bash
$ ls -lh
total 3.9G
-rw-r--r--. 1 jostho jostho 1.5G Feb 23 20:50 centos-8-rootfs.ext4
-rw-r--r--. 1 jostho jostho 1.2G Feb 23 20:52 ubuntu-18-rootfs.ext4
-rw-r--r--. 1 jostho jostho 1.2G Feb 23 20:52 ubuntu-20-rootfs.ext4
-rwxr-xr-x. 1 jostho jostho  35M Feb 22 20:53 vmlinux-5.4.99
```

## Kernel

Build kernel on a CentOS Stream box

```bash
sudo dnf install -y make gcc flex bison elfutils-libelf-devel openssl-devel perl
```

Prepare a working directory

```bash
mkdir -p ~/src && cd ~/src
```

Get kernel sources

```bash
curl -LO https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.4.99.tar.xz
```

Get config file from [ignite](https://github.com/weaveworks/ignite) project

```bash
curl -O https://raw.githubusercontent.com/weaveworks/ignite/master/images/kernel/versioned/config-amd64-5.4.43
```

Prepare kernel sources for build

```bash
tar xf ./linux-5.4.99.tar.xz
cp ./config-amd64-5.4.43 ./linux-5.4.99/.config
```

Build the kernel

```bash
cd ~/src/linux-5.4.99 && make vmlinux
```

Copy `vmlinux` file to the `boot/` directory.
