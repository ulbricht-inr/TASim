#!/bin/bash
 sudo brctl addbr br0
 sudo brctl addif br0 TN1
 sudo brctl addif br0 TN2
 sudo ifconfig br0 up 
 sudo modprobe br_netfilter
