# TASim
Dummy network interface bridge with multi-queuing to test taprio also without intel NIC

the code based on the Networkdriver of the TrustNode TSN switch: https://github.com/InnoRoute/packages/tree/master/TrustNodeDriver


## How tu use:
if you have the Kernel 5.2.x installed, ignore the install scripts just :

* make 
* ./installdriver.sh

The driver will create 4  virtual interfaces TN0..TN3, pairs of two are connected with eachother.
TN0<-->TN1, TN2<-->TN3. Each interface have 8 TX queues. 

## TSN example:

```
sudo tc qdisc add dev TN2 parent root handle 100 taprio \
num_tc 2 \
map 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 \
queues 1@0 1@1 \
base-time 0 \
sched-entry S 01 500000000 sched-entry S 02 500000000 \
clockid CLOCK_TAI
sudo iptables -t mangle -A POSTROUTING -d 1.1.1.1 -j CLASSIFY --set-class 0:1
sudo iptables -t mangle -A POSTROUTING -d 2.2.2.2 -j CLASSIFY --set-class 0:0
sudo brctl addbr br0 # we have to this trick because iptables don't work with replayed packets directly
sudo brctl addif br0 TN1
sudo brctl addif br0 TN2
sudo ifconfig br0 up 
sudo modprobe br_netfilter

sudo tcpreplay -i TN0 -p10 --loop=0 testpackets.pcap
sudo tcpdump -i TN3 -n

```

more description of the configuration, see https://www.frank-durr.de/?p=376 
