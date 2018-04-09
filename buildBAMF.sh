#Prerequisites:
#  1. Install PhotonOS
#  2. Change root password
#  3. Run vi /etc/resolv.conf - add 8.8.8.8 and 8.8.8.4 as nameservers
#
systemctl start docker
systemctl enable docker
mkdir /usr/local/nodejs
cd /usr/local/nodejs
yum install iputils git nodejs wget tar unzip make
iptables -A INPUT -p tcp --dport 3000 -j ACCEPT
iptables -A OUTPUT  -p tcp --dport 3000 -j ACCEPT
npm install express --save
npm i express-handlebars
npm i socket.io
npm i url
npm i sys
npm i path
git clone https://github.com/bocbusinesssolutions/BAMFBeta2.git

