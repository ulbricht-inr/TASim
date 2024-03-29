#!/bin/bash
#TASim setup script 
#two stages, 
#	1: install kernel 5.2.15 and reboot with new kernel
#	2: install iproute2 tcpdump, tcpreplay, compile TASim and load driver
if [ "$#" -eq "1" ];then
	if [ "$1" -eq "1" ];then
		read -p "This script will install kernel 5.2.15 and reboot with the new kernel, press [STRG]+[C] to cancel."

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
	  echo "cheking kernel version:"
	  uname -a
	  uname -a | grep "5.2.15"
	  if [ $? -ne 0 ]; then
	  	echo "please install kernel 5.2.15 first"
	  	echo "run setup.sh 1"
	  	exit 1
	  
	  fi
	  echo "installing iproute2..."
		mkdir iproute2
		sudo apt-get install -y libdb5.3-dev build-essential bison flex
		cd iproute2
		wget http://ftp.de.debian.org/debian/pool/main/i/iproute2/iproute2_5.2.0-1_amd64.deb
		sudo dpkg -i iproute2_5.2.0-1_amd64.deb
		cd ..
	
		
		echo "installing tcpreplay tcpdump and bridge-utils"
		sudo apt-get install -y tcpreplay tcpdump bridge-utils
		
		echo "make TASim..."
		make
		echo "installing network driver..."
		./installdriver.sh
	
	
	fi


else
	echo "please selct mode 1 or 2"
fi
