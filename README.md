# Pyrogen

![CI](https://github.com/jostho/pyrogen/workflows/CI/badge.svg)

This project has sources to run [firecracker](https://github.com/firecracker-microvm/firecracker) VMs on fedora.

## Environment

* fedora 36
* firecracker 1.1

## Setup

Follow the [getting started](https://github.com/firecracker-microvm/firecracker/blob/master/docs/getting-started.md) guide
* provide access to `/dev/kvm` device
* download the firecracker binary and add to `PATH`

See [boot README](boot/README.md) on how to create kernel and rootfs image files.
Place the files in `boot/` directory.

## Run

Start networking

```bash
sudo ./fc-net.sh start
```

Start VMs

```bash
./fc-vm.sh start
```

Check status of VMs

```bash
./fc-vm.sh status
```
