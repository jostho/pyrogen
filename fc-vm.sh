#!/bin/bash

# control firecracker VM processes

ALL_VM="centos-8 ubuntu-18 ubuntu-20"

fc_vm_start() {
  for vm in $ALL_VM
  do
    nohup firecracker --no-api --config-file config-${vm}.json > nohup-${vm}.out &
  done
}

fc_vm_stop() {
  FC_PIDS=$(ps --no-headers -o pid -C firecracker)
  if [ $? -eq 0 ]
  then
    kill $FC_PIDS
  fi
}

fc_vm_status() {
  ps -ww -o pid,ppid,uid,rss,etime,args -C firecracker
}

fc_vm_check() {
  exit_code=0
  for vm in $ALL_VM
  do
    if [ ! -f ./boot/${vm}-rootfs.ext4 ]
    then
      echo "${vm}-rootfs.ext4 does not exist"
      exit_code=1
    fi
  done
  exit $exit_code
}

# decide operation
case "$1" in
  start)
    fc_vm_start
    ;;
  stop)
    fc_vm_stop
    ;;
  status)
    fc_vm_status
    ;;
  check)
    fc_vm_check
    ;;
  *)
    echo "Usage: $(basename $0) {start|stop|status|check}"
    exit 2
    ;;
esac
