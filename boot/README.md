# Boot directory setup

This directory holds the files required for boot.

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
