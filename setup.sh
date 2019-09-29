#!/bin/bash
#TASim setup script 
#two stages, 
#	1: install kernel 5.2.15 and reboot with new kernel
#	2: install iproute2 tcpdump, tcpreplay, compile TASim and load driver
if [ "$#" -eq "1" ];then
	if [ "$1" -eq "1" ];then
		mkdir kernel5.2
		cd kernel5.2
		echo "downloading...."
		wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.2.15/linux-headers-5.2.15-050215_5.2.15-050215.201909160732_all.deb
		wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.2.15/linux-headers-5.2.15-050215-generic_5.2.15-050215.201909160732_amd64.deb
		wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.2.15/linux-image-unsigned-5.2.15-050215-generic_5.2.15-050215.201909160732_amd64.deb
		wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.2.15/linux-modules-5.2.15-050215-generic_5.2.15-050215.201909160732_amd64.deb
		echo "installing new kernel...."
		sudo dpkg -i *.deb
		echo "going to reboot now....."
		sudo reboot
	
	
	else
	
	
	
	
	fi


else
	echo "please selct mode 1 or 2"
fi
