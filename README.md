<p align="center">
  <img src="https://bitcoinwspectrum.com/wp-content/uploads/2018/08/img_00.png" width="250"/>
</p>

# <h>  VPS Masternode with TOR ready setup script. </h>

To run the script simply type the following commands into your VPS terminal. 
 
`wget https://github.com/bitcoinwspectrum/mn_install/releases/download/5/Bws_Setup.sh && chmod 755 Bws_Setup.sh && ./Bws_Setup.sh`

<h1> Masternode Basic Requirements </h1>

- 50,000 BWS

- Main Computer with BWS wallet installed

- Masternode Server

- Unique IP address for EACH masternode

<h1> Local Wallet Procedure </h1>

Step 1) Download, install and sync your BWS wallet
Download link for all Operating systems:
https://github.com/raymaker/bitcoinwspectrum/releases

Step 2) Using your main wallet, enter the debug console and type the following command:

- `masternode genkey`

- Please save this on a Notepad

Step 3) Using your main wallet, enter the debug console and type the following command:

- `getaccountaddress INSERT_MASTERNODE_NAME`

- Please save this on a Notepad

Step 4) Send 50,000 BWS to Step 3 address.

Step 5)  Using your main wallet, wait for 15 confirmations, and then enter the debug console and type the following command:

- `masternode outputs`
- Please save this on a Notepad 

Step 6) Locate your masternode.conf and add the following line: 

<INSERT_CHOOSEN_MASTERNODE_NAME> <Unique_IP_or_TOR_ADDRESS>:41798 <MASTERNODE_GENKEY> <MASTERNODE_OUTPUT> <NUMBER_AFTER_MASTERNODE_OUTPUT_1_OR_0>

Note: Substitute it with your own values and without the “<>”s

Example:
MN1 31.11.135.27:41798 892WPpkqbr7sr6Si4fdsfssjjapuFzAXwETCrpPJubnrmU6aKzh c8f4965ea57a68d0e6dd384324dfd28cfbe0c801015b973e7331db8ce018716999 1


<h2> Run and follow the instructions on the script </h2> 

<h1> TOR Activation </h1>

Step 1 - Find the node onion address

Command: `./bws-cli getnetworkinfo`

Look for the TOR address at the end of the output (EG. aedFAWE235AGa2.onion)

Step 2 - Edit your LOCAL (Not VPS) masternode.conf by replacing the old IP address with the new .onion TOR address.

Step 3 - Restart the local wallet
Windows, Max and Linux GUI; Close and open your wallet

Linux CLI:

Command: `./bws-cli stop`
then:   `./bwsd -reindex`

Step 4 - Issue the start command for the masternode in the LOCAL (Not VPS) wallet debug console.

For example: `startmasternode alias 0 MN01`

Note:
Where by MN01 is your chosen Masternode name
Wait a few minutes for the MN ip address to change to the onion address in the masternode tab.

Step 5 - Restart the wallet on the VPS with the following commands.

Command: `./bws-cli stop`

then:   `./bwsd -reindex`

Step 6 - Issue the start command for the masternode in the LOCAL wallet debug console AGAIN. ie follow step 4 again. 

Step 7 - Wait up to 30 minutes for the MN timer to change from 00:00 to a postive time in the masternode tab.

Note:
You can check to see if it updated to the onion address in the VPS using: 
./bws-cli masternode status
