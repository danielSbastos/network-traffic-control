#!/bin/bash

IF=wlo1

create () {
  echo "== SHAPING INIT =="

  # create the root qdisc
  sudo tc qdisc add dev $IF root handle 1: cbq avpkt 1000 bandwidth 100mbit

  sudo tc class add dev $IF parent 1: classid 1:2 cbq rate 100mbit allot 1500 prio 5 bounded isolated
  sudo tc filter add dev $IF parent 1: protocol ip prio 16 u32 match ip dst 10.42.0.91 flowid 1:2
  sudo tc qdisc add dev $IF parent 1:2 handle 12: netem delay 100ms

  sudo tc class add dev $IF parent 1: classid 1:4 cbq rate 100mbit allot 1500 prio 5 bounded isolated
  sudo tc filter add dev $IF parent 1: protocol ip prio 16 u32 match ip dst 10.42.0.131 flowid 1:4
  sudo tc qdisc add dev $IF parent 1:4 handle 14: netem drop 5%

  sudo tc class add dev $IF parent 1: classid 1:3 cbq rate 2mbit allot 1500 prio 5 bounded isolated
  sudo tc filter add dev $IF parent 1: protocol ip prio 16 u32 match ip dst 10.42.0.70 flowid 1:3

  echo "== SHAPING DONE =="
}

# run clean to ensure existing tc is not configured
clean () {
  echo "== CLEAN INIT =="
  sudo tc qdisc del dev $IF root
  echo "== CLEAN DONE =="
}

clean
create

