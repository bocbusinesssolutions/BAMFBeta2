#Prerequisites:
#  1a. Deploy PhotonOS
#  2a. Change root password
#  3a. Run vi /etc/resolv.conf - add 8.8.8.8 and 8.8.8.4 as nameservers
#  4a. Run yum install git
#  5a. Clone BAMFBeta2 repository
#
#  1b. Deploy RHEL
#  2b. Login using SSH security key
#  3b. Run curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
#  4b. Run curl --silent --location https://rpm.nodesource.com/setup_9.x | sudo bash -
#  5b. Run sudo yum -y install nodejs
#  6b. Run sudo yum install git
#  7b. Clone BAMFBeta2 repository
#  
systemctl start docker
systemctl enable docker
yum install iputils git nodejs wget tar unzip make
iptables -A INPUT -p tcp --dport 3000 -j ACCEPT
iptables -A OUTPUT  -p tcp --dport 3000 -j ACCEPT
npm install express --save
npm i express-handlebars
npm i socket.io
npm i url
npm i sys
npm i path
