#/bin/bash
cd ~
rm -rf Bws_Setup.sh* BwsUpdate.sh*
echo "****************************************************************************"
echo "* This script will install and configure your BWS Coin masternodes.       *"
echo "*                    Love from A_Block_Nut(Thermo) ;)                      *"
echo "*    If you have any issues please ask for help on the BWS discord.       *"
echo "*                      https://discord.gg/3Z7DUEC                        *"
echo "*                        https://bitcoinwspectrum.com/                             *"
echo "****************************************************************************"
echo "" 
echo ""
echo "!!!!!!!!!!PLEASE READ CAREFULLY!!!!!!!!!!!!!!!"
echo ""
echo "***********************************************************************************"
echo "* It is very important to program your masternode under a user rather than root.	*"
echo "* 		By entering Yes you will create a new user.								*"
echo "* You Dont need to enter any personal details but you do need to create password.	*"
echo "*																					*"
echo "*----Are you running this script as the root user? [y/n], followed by [ENTER]-----*"
echo "* 																				*"
echo "*	------------------------OPTIONS BELOW-------------------------------------------*"
echo "* 1 - Enter Yes If you are running this Script as root then re-run this script	*"
echo "* 2 - Enter Yes If you want to get into your created user							*"
echo "*																					*"
echo "* 3 - Please Enter No if you are running this Script under your new user.			*"
echo "***********************************************************************************"
read USETUP
	if 
	[[ $USETUP =~ "y" ]] || [[$USETUP =~ "Y" ]] ; then
	
sudo adduser bws
usermod -aG sudo bws
sudo su - bws
fi
echo ""
echo ""
echo ""
echo "Do you to use our Express Masternode/Wallet installation? [y/n], followed by [ENTER]"
echo ""
echo ""
read EXSETUP
	if 
	[[ $EXSETUP =~ "y" ]] || [[$EXSETUP =~ "Y" ]] ; then
sudo su -c "echo 'deb http://deb.torproject.org/torproject.org '$(lsb_release -c | cut -f2)' main' > /etc/apt/sources.list.d/torproject.list"
	gpg --keyserver keys.gnupg.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89
	gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -
	sudo apt-get update
	sudo apt-get install tor deb.torproject.org-keyring -y
	sudo usermod -a -G debian-tor $(whoami)

	sudo sed -i 's/#ControlPort 9051/ControlPort 9051/g' /etc/tor/torrc
	sudo sed -i 's/#CookieAuthentication 1/CookieAuthentication 1/g' /etc/tor/torrc 
	sudo su -c "echo 'CookieAuthFileGroupReadable 1' >> /etc/tor/torrc"
	sudo su -c "echo 'LongLivedPorts 9033' >> /etc/tor/torrc"
	sudo systemctl restart tor.service
	rm -rf Bws_Setup.sh* BwsUpdate.sh*
	./bws-cli stop
echo "configure your VPS with Bws recommended settings"
	sudo apt-get update
	sudo apt-get -y upgrade
	sudo apt-get -y dist-upgrade
	
	sudo apt-get install -y ufw
	sudo ufw allow ssh/tcp
	sudo ufw limit ssh/tcp
	sudo ufw logging on
	sudo ufw allow 22
	sudo ufw allow 41798
        sudo ufw allow 9033
	echo "y" | sudo ufw enable
	sudo ufw status
	
echo ""
echo ""
echo ""
echo "installing/updating your Masternode"
./bws-cli stop
rm bwsd
rm bws-cli
rm bws-tx
wget https://github.com/bitcoinwspectrum/bws-linux-cli/releases/download/bws-cli/bws-linux-cli.tar
tar -xf bws-linux-cli.tar
rm bws-linux-cli.tar
sudo su -c "echo 'listenonion=1' >> /.bws/bws.conf"
fi
echo "Masternode Configuration"
echo "Your recognised IP address is:"
sudo hostname -I 
echo "Is this the IP you wish to use for MasterNode ? [y/n] , followed by [ENTER]"
read IPDEFAULT
	if
	[[ $IPDEFAULT =~ "y" ]] || [[$IPDEFAULT =~ "Y" ]] ; then
	echo ""
	echo "We are using your default IP address"
	echo "Enter masternode private key for node, followed by [ENTER]: $ALIAS"
	read PRIVKEY
	CONF_DIR=~/.bws\/
	CONF_FILE=bws.conf
	PORT=41798
	IP=$(hostname -I)
	mkdir -p $CONF_DIR
	echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
	echo "rpcpassword=passw"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
	echo "rpcallowip=127.0.0.1" >> $CONF_DIR/$CONF_FILE
	echo "listen=1" >> $CONF_DIR/$CONF_FILE
	echo "server=1" >> $CONF_DIR/$CONF_FILE
	echo "daemon=1" >> $CONF_DIR/$CONF_FILE
	echo "logtimestamps=1" >> $CONF_DIR/$CONF_FILE
	echo "maxconnections=256" >> $CONF_DIR/$CONF_FILE
	echo "masternode=1" >> $CONF_DIR/$CONF_FILE
	echo "" >> $CONF_DIR/$CONF_FILE
	echo "" >> $CONF_DIR/$CONF_FILE
	echo "port=$PORT" >> $CONF_DIR/$CONF_FILE
	echo "masternodeaddr=$IP:$PORT" >> $CONF_DIR/$CONF_FILE
	echo "masternodeprivkey=$PRIVKEY" >> $CONF_DIR/$CONF_FILE
	sudo su -c "echo 'listenonion=1' >> /.bws/bws.conf"
	./bwsd -resync
	echo "if server start failure try ./bwsd -reindex"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo "!                                                 !"
	echo "! Your MasterNode Is setup please close terminal  !"
	echo "!   and continue the local wallet setup guide     !"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo ""
else	
	echo "Type the custom IP of this node, followed by [ENTER]:"
	read DIP
	echo ""
	echo "Enter masternode private key for node, followed by [ENTER]: $ALIAS"
	read PRIVKEY
	CONF_DIR=~/.bws\/
	CONF_FILE=bws.conf
	PORT=41798
	mkdir -p $CONF_DIR
	echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
	echo "rpcpassword=passw"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
	echo "rpcallowip=127.0.0.1" >> $CONF_DIR/$CONF_FILE
	echo "listen=1" >> $CONF_DIR/$CONF_FILE
	echo "server=1" >> $CONF_DIR/$CONF_FILE
	echo "daemon=1" >> $CONF_DIR/$CONF_FILE
	echo "logtimestamps=1" >> $CONF_DIR/$CONF_FILE
	echo "maxconnections=256" >> $CONF_DIR/$CONF_FILE
	echo "masternode=1" >> $CONF_DIR/$CONF_FILE
	echo "" >> $CONF_DIR/$CONF_FILE
	echo "" >> $CONF_DIR/$CONF_FILE
	echo "port=$PORT" >> $CONF_DIR/$CONF_FILE
	echo "masternodeaddr=$DIP:$PORT" >> $CONF_DIR/$CONF_FILE
	echo "masternodeprivkey=$PRIVKEY" >> $CONF_DIR/$CONF_FILE
	sudo su -c "echo 'listenonion=1' >> /.bws/bws.conf"
	./bwsd -resync
	echo "if server start failure try ./bwsd -reindex"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo "!                                                 !"
	echo "! Your MasterNode Is setup please close terminal  !"
	echo "!   and continue the local wallet setup guide     !"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo ""
fi
else 

echo ""
echo "Do you want TOR Integrated into this VPS? [y/n], followed by [ENTER]"
echo ""
echo ""
read TSETUP
	if 
	[[ $TSETUP =~ "y" ]] || [[$TSETUP =~ "Y" ]] ; then
sudo su -c "echo 'deb http://deb.torproject.org/torproject.org '$(lsb_release -c | cut -f2)' main' > /etc/apt/sources.list.d/torproject.list"
	gpg --keyserver keys.gnupg.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89
	gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -
	sudo apt-get update
	sudo apt-get install tor deb.torproject.org-keyring -y
	sudo usermod -a -G debian-tor $(whoami)

	sudo sed -i 's/#ControlPort 9051/ControlPort 9051/g' /etc/tor/torrc
	sudo sed -i 's/#CookieAuthentication 1/CookieAuthentication 1/g' /etc/tor/torrc 
	sudo su -c "echo 'CookieAuthFileGroupReadable 1' >> /etc/tor/torrc"
	sudo su -c "echo 'LongLivedPorts 9033' >> /etc/tor/torrc"
	sudo systemctl restart tor.service
	rm -rf Bws_Setup.sh* BwsUpdate.sh*
	./bws-cli stop
	fi
echo ""
echo ""
echo "Do you want to configure your VPS with Bws recommended settings? [y/n], followed by [ENTER]"
read DOSETUP
	if 
	[[ $DOSETUP =~ "y" ]] || [[$DOSETUP =~ "Y" ]] ; then
	sudo apt-get update
	sudo apt-get -y upgrade
	sudo apt-get -y dist-upgrade
	
	sudo apt-get install -y ufw
	sudo ufw allow ssh/tcp
	sudo ufw limit ssh/tcp
	sudo ufw logging on
	sudo ufw allow 22
	sudo ufw allow 41798
        sudo ufw allow 9033
	echo "y" | sudo ufw enable
	sudo ufw status
	fi
echo ""
echo ""
echo ""
echo "Are you installing/updating your Masternode? [y/n]"
read MSETUP
if
[[ $MSETUP =~ "y" ]] || [[$MSETUP =~ "Y" ]] ; then
./bws-cli stop
rm bwsd
rm bws-cli
rm bws-tx
wget https://github.com/bitcoinwspectrum/bws-linux-cli/releases/download/bws-cli/bws-linux-cli.tar
tar -xf bws-linux-cli.tar
rm bws-linux-cli.tar
sudo su -c "echo 'listenonion=1' >> /.bws/bws.conf"
echo "Masternode Configuration"
echo "Your recognised IP address is:"
sudo hostname -I 
echo "Is this the IP you wish to use for MasterNode ? [y/n] , followed by [ENTER]"
read IPDEFAULT
	if
	[[ $IPDEFAULT =~ "y" ]] || [[$IPDEFAULT =~ "Y" ]] ; then
	echo ""
	echo "We are using your default IP address"
	echo "Enter masternode private key for node, followed by [ENTER]: $ALIAS"
	read PRIVKEY
	CONF_DIR=~/.bws\/
	CONF_FILE=bws.conf
	PORT=41798
	IP=$(hostname -I)
	mkdir -p $CONF_DIR
	echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
	echo "rpcpassword=passw"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
	echo "rpcallowip=127.0.0.1" >> $CONF_DIR/$CONF_FILE
	echo "listen=1" >> $CONF_DIR/$CONF_FILE
	echo "server=1" >> $CONF_DIR/$CONF_FILE
	echo "daemon=1" >> $CONF_DIR/$CONF_FILE
	echo "logtimestamps=1" >> $CONF_DIR/$CONF_FILE
	echo "maxconnections=256" >> $CONF_DIR/$CONF_FILE
	echo "masternode=1" >> $CONF_DIR/$CONF_FILE
	echo "" >> $CONF_DIR/$CONF_FILE
	echo "" >> $CONF_DIR/$CONF_FILE
	echo "port=$PORT" >> $CONF_DIR/$CONF_FILE
	echo "masternodeaddr=$IP:$PORT" >> $CONF_DIR/$CONF_FILE
	echo "masternodeprivkey=$PRIVKEY" >> $CONF_DIR/$CONF_FILE
	sudo su -c "echo 'listenonion=1' >> /.bws/bws.conf"
	./bwsd -resync
	echo "if server start failure try ./bwsd -reindex"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo "!                                                 !"
	echo "! Your MasterNode Is setup please close terminal  !"
	echo "!   and continue the local wallet setup guide     !"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo ""
else	
	echo "Type the custom IP of this node, followed by [ENTER]:"
	read DIP
	echo ""
	echo "Enter masternode private key for node, followed by [ENTER]: $ALIAS"
	read PRIVKEY
	CONF_DIR=~/.bws\/
	CONF_FILE=bws.conf
	PORT=41798
	mkdir -p $CONF_DIR
	echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
	echo "rpcpassword=passw"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
	echo "rpcallowip=127.0.0.1" >> $CONF_DIR/$CONF_FILE
	echo "listen=1" >> $CONF_DIR/$CONF_FILE
	echo "server=1" >> $CONF_DIR/$CONF_FILE
	echo "daemon=1" >> $CONF_DIR/$CONF_FILE
	echo "logtimestamps=1" >> $CONF_DIR/$CONF_FILE
	echo "maxconnections=256" >> $CONF_DIR/$CONF_FILE
	echo "masternode=1" >> $CONF_DIR/$CONF_FILE
	echo "" >> $CONF_DIR/$CONF_FILE
	echo "" >> $CONF_DIR/$CONF_FILE
	echo "port=$PORT" >> $CONF_DIR/$CONF_FILE
	echo "masternodeaddr=$DIP:$PORT" >> $CONF_DIR/$CONF_FILE
	echo "masternodeprivkey=$PRIVKEY" >> $CONF_DIR/$CONF_FILE
	sudo su -c "echo 'listenonion=1' >> /.bws/bws.conf"
	./bwsd -resync
	echo "if server start failure try ./bwsd -reindex"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo "!                                                 !"
	echo "! Your MasterNode Is setup please close terminal  !"
	echo "!   and continue the local wallet setup guide     !"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo ""
fi
fi
