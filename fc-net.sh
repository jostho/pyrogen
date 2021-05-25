#!/bin/bash

# control firecracker networking
# run as root

ALL_TNUM="18 20"

if [ "$EUID" -ne 0 ]
then
  echo "Please run $(basename "$0") as root"
  exit 1
fi

fc_net_start() {
  # stop firewalld
  systemctl stop firewalld

  # setup ip forwarding
  sysctl -w net.ipv4.ip_forward=1

  EGRESS_DEVICE=wlp5s0

  # iptables for routing tuntap traffic
  iptables -t nat -A POSTROUTING -o $EGRESS_DEVICE -j MASQUERADE
  iptables -t filter -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

  last_octet=17
  for tnum in $ALL_TNUM
  do
    tap_device=tap${tnum}
    ip link del $tap_device 2> /dev/null
    ip tuntap add $tap_device mode tap
    sysctl -w net.ipv4.conf.${tap_device}.proxy_arp=1
    sysctl -w net.ipv6.conf.${tap_device}.disable_ipv6=1
    ip addr add 172.28.28.${last_octet}/28 dev $tap_device
    ip link set address 42:fc:c0:de:${tnum}:01 dev $tap_device
    ip link set $tap_device up
    iptables -t filter -A FORWARD -i $tap_device -o $EGRESS_DEVICE -j ACCEPT
    ip addr show $tap_device
    # increment by 16, since it is a /28 network
    (( last_octet=last_octet+16 ))
  done
}

fc_net_stop() {
  # start firewalld
  systemctl start firewalld

  # reset ip forwarding
  sysctl -w net.ipv4.ip_forward=0

  # flush iptables
  iptables -F

  # delete tap devices
  for tnum in $ALL_TNUM
  do
    ip link del tap${tnum}
  done
}

# decide operation
case "$1" in
  start)
    fc_net_start
    ;;
  stop)
    fc_net_stop
    ;;
  *)
    echo "Usage: $(basename "$0") {start|stop}"
    exit 2
    ;;
esac
