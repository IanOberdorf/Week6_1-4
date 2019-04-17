echo Task 2 Changing Eth1 script
cd /etc/sysconfig/network-scripts
echo -e "DEVICE=eth1 \nBOOTPROTO=none \nPREFIX=24 \nIPADDR=192.168.100.11" >> ./ifcfg-eth1
echo Restarting Interface
ifdown eth1
ifup eth1
echo configuring DHCPD
cd /etc/dhcp
echo -e '\ndefault-lease-time 600; \nmax-lease-time 7200; \n\nddns-update-style interim; \nignore client-updates; \n\nsubnet 192.168.100.0 netmask 255.255.255.0 { \n range 192.168.100.12 192.168.100.254; \noption routers 192.168.100.1; \noption domain-name "linux.net"; \noption domain-name-servers 192.168.100.10; \n}' >> ./dhcpd.conf
echo Restarting DHCPD
systemctl start dhcpd.service
sleep 20
systemctl status dhcpd.service
echo -e '\n\nIf the previous shows red text stating "\e[91mon ftp.isc.org. Features have been added and other changes have been made to the base software release in order to make it work better with this distribution." \e[39mThen restart the lab.'
