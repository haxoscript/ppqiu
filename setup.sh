#!/bin/bash
clear

if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi

red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
echo "Checking VPS"
echo -e "${green}Permission Accepted...${NC}"
sleep 1
clear

if [ -f "/etc/v2ray/domain" ]; then
echo "This Script Already Installed..."
exit 0
fi

MYIP=$(wget -qO- icanhazip.com);
mkdir /var/lib/premium-script;
read -p "Tulis Domain Awal : " sub
SUB_DOMAIN=${sub}
echo "Hostname : $SUB_DOMAIN"
echo "IP=$SUB_DOMAIN" >> /var/lib/premium-script/ipvps.conf

#install SSH
wget https://github.com/haxoscript/ppqiu/raw/main/ssh-vpn.sh && bash ssh-vpn.sh
#install V2RAY
wget https://github.com/haxoscript/ppqiu/raw/main/ins-vt.sh && bash ins-vt.sh
#install L2TP
wget https://github.com/haxoscript/ppqiu/raw/main/ipsec.sh && bash ipsec.sh

rm -f /root/ssh-vpn.sh
rm -f /root/ins-vt.sh
rm -f /root/ipsec.sh

history -c
echo "1.1" > /home/ver
clear
echo " "
echo "Installation has been completed!!"
echo " "
echo "=================================-Autoscript Premium-===========================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "--------------------------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo "   - L2TP/IPSEC VPN          : 1701"  | tee -a log-install.txt
echo "   - PPTP VPN                : 1732"  | tee -a log-install.txt
echo "   - V2RAY Vmess TLS         : 444"  | tee -a log-install.txt
echo "   - V2RAY Vmess None TLS    : 445"  | tee -a log-install.txt
echo "   - V2RAY Vless TLS         : 446"  | tee -a log-install.txt
echo "   - V2RAY Vless None TLS    : 447"  | tee -a log-install.txt
echo "   - Trojan                  : 443"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 00.00 GMT +7" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "--------------------------------------------------------------------------------" | tee -a log-install.txt
echo ""
echo " Reboot 10 Sec"
sleep 10
rm -f /root/setup.sh
reboot
