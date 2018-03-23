Steps to deploy/configure platform for BAMF

1. Deploy PhotonOS 2.0 on vSphere. When IP Address becomes available, initiate PuttY session. 

2. First time login root/changeme
		login as: root
		Using keyboard-interactive authentication.
		Password:
		Using keyboard-interactive authentication.
		You are required to change your password immediately (administrator enforced)
		Changing password for root.
		Current password:
		Using keyboard-interactive authentication.
		New password:
		Using keyboard-interactive authentication.
		Retype new password:
		 17:47:29 up 3 min,  0 users,  load average: 0.01, 0.01, 0.00
		tdnf update info not available yet!
		root@photon-machine [ ~ ]#
		root@photon-machine [ ~ ]#

3. Start docker
		root@photon-machine [ ~ ]# systemctl docker start
		Unknown operation docker.
		root@photon-machine [ ~ ]# systemctl start docker
		root@photon-machine [ ~ ]# systemctl enable docker
		Created symlink /etc/systemd/system/multi-user.target.wants/docker.service â /lib/systemd/system/docker.service.
		root@photon-machine [ ~ ]#

4. Configure DNS: vi /etc/resolv.conf
		# This file is managed by man:systemd-resolved(8). Do not edit.
		#
		# This is a dynamic resolv.conf file for connecting local clients directly to
		# all known DNS servers.
		#
		# Third party programs must not access this file directly, but only through the
		# symlink at /etc/resolv.conf. To manage man:resolv.conf(5) in a different way,
		# replace this symlink by a static file or a different symlink.
		#
		# See man:systemd-resolved.service(8) for details about the supported modes of
		# operation for /etc/resolv.conf.

		nameserver 8.8.8.8
		nameserver 8.8.8.4
		nameserver 172.16.0.1

5. Install iputils
		root@photon-machine [ ~ ]# yum install iputils
		Refreshing metadata for: 'VMware Photon Linux 2.0(x86_64)'
		Refreshing metadata for: 'VMware Photon Linux 2.0(x86_64) Updates'
		Refreshing metadata for: 'VMware Photon Extras 2.0(x86_64)'
		photon-extras                              106    100%
		Installing:
		libgpg-error                                    x86_64                  1.27-1.ph2                      photon                   118.88k 121733
		libgcrypt                                       x86_64                  1.8.1-1.ph2                     photon                    1.18M 1235073
		iputils                                         x86_64                  20151218-4.ph2                  photon                   262.51k 268810
		
		Total installed size:   1.55M 1625616
		Is this ok [y/N]:y
		
		Downloading:
		iputils                                 129855    100%
		libgcrypt                               510631    100%
		libgpg-error                             61382    100%
		Testing transaction
		Running transaction
		Installing/Updating: libgpg-error-1.27-1.ph2.x86_64
		Installing/Updating: libgcrypt-1.8.1-1.ph2.x86_64
		Installing/Updating: iputils-20151218-4.ph2.x86_64
		
		Complete!
		root@photon-machine [ ~ ]#

		root@photon-machine [ ~ ]# ping 8.8.8.8
		PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
		64 bytes from 8.8.8.8: icmp_seq=1 ttl=55 time=28.8 ms
		64 bytes from 8.8.8.8: icmp_seq=2 ttl=55 time=17.6 ms
		64 bytes from 8.8.8.8: icmp_seq=3 ttl=55 time=23.1 ms
		^C
		--- 8.8.8.8 ping statistics ---
		3 packets transmitted, 3 received, 0% packet loss, time 2003ms
		rtt min/avg/max/mdev = 17.666/23.232/28.868/4.573 ms
		root@photon-machine [ ~ ]# ping google.com
		PING google.com (172.217.10.78) 56(84) bytes of data.
		64 bytes from lga34s14-in-f14.1e100.net (172.217.10.78): icmp_seq=1 ttl=53 time=39.7 ms
		64 bytes from lga34s14-in-f14.1e100.net (172.217.10.78): icmp_seq=2 ttl=53 time=38.6 ms
		64 bytes from lga34s14-in-f14.1e100.net (172.217.10.78): icmp_seq=3 ttl=53 time=38.6 ms
		^C
		--- google.com ping statistics ---
		3 packets transmitted, 3 received, 0% packet loss, time 2002ms
		rtt min/avg/max/mdev = 38.610/38.983/39.721/0.521 ms

6. Create local repo for nodejs
		root@photon-machine [ ~ ]# mkdir /usr/local/nodejs
		root@photon-machine [ ~ ]# cd /usr/local/nodejs
		root@photon-machine [ /usr/local/nodejs ]# ls
		root@photon-machine [ /usr/local/nodejs ]#

7. Install node.js
		root@photon-machine [ /usr/local/nodejs ]# yum install nodejs

		Installing:
		nodejs                                          x86_64                  8.3.0-1.ph2                     photon-updates           41.90M 43932398

		Total installed size:  41.90M 43932398
		Is this ok [y/N]:y

		Downloading:
		nodejs                                15107964    100%
		Testing transaction
		Running transaction
		Installing/Updating: nodejs-8.3.0-1.ph2.x86_64

		Complete!
		root@photon-machine [ /usr/local/nodejs ]# node
		>
		(To exit, press ^C again or type .exit)
		> exit

8. Open port 3000
		root@photon-machine [ /usr/local/nodejs ]# iptables -A INPUT -p tcp  --dport 3000 -j ACCEPT
		root@photon-machine [ /usr/local/nodejs ]# iptables -A OUTPUT -p tcp  --dport 3000 -j ACCEPT

9. Install Express
		root@photon-machine [ /usr/local/nodejs ]# npm install express --save
		npm WARN saveError ENOENT: no such file or directory, open '/usr/local/nodejs/package.json'
		npm notice created a lockfile as package-lock.json. You should commit this file.
		npm WARN enoent ENOENT: no such file or directory, open '/usr/local/nodejs/package.json'
		npm WARN nodejs No description
		npm WARN nodejs No repository field.
		npm WARN nodejs No README data
		npm WARN nodejs No license field.

		+ express@4.16.3
		added 49 packages in 4.731s
		root@photon-machine [ /usr/local/nodejs ]#

10. Install Express Handlebars
		root@photon-machine [ /usr/local/nodejs/BAMF01 ]# npm i express-handlebars
		npm WARN saveError ENOENT: no such file or directory, open '/usr/local/nodejs/package.json'
		npm WARN enoent ENOENT: no such file or directory, open '/usr/local/nodejs/package.json'
		npm WARN nodejs No description
		npm WARN nodejs No repository field.
		npm WARN nodejs No README data
		npm WARN nodejs No license field.

		+ express-handlebars@3.0.0
		added 43 packages in 5.613s

11. Install git
		root@photon-machine [ /usr/local/nodejs ]# yum install git

		Installing:
		perl-YAML                                       noarch                  1.23-1.ph2                      photon                   129.58k 132693
		perl                                            x86_64                  5.24.1-4.ph2                    photon                   49.41M 51811861
		perl-DBI                                        x86_64                  1.636-1.ph2                     photon                    1.79M 1881403
		perl-CGI                                        noarch                  4.35-1.ph2                      photon                   536.92k 549802
		git                                             x86_64                  2.14.2-1.ph2                    photon                   20.25M 21238241

		Total installed size:  72.11M 75614000
		Is this ok [y/N]:y

		Downloading:
		git                                   10040311    100%
		perl-CGI                                236298    100%
		perl-DBI                                786780    100%
		perl                                  18290806    100%
		perl-YAML                                67053    100%
		Testing transaction
		Running transaction
		Installing/Updating: perl-5.24.1-4.ph2.x86_64
		Installing/Updating: perl-CGI-4.35-1.ph2.noarch
		Installing/Updating: perl-DBI-1.636-1.ph2.x86_64
		Installing/Updating: perl-YAML-1.23-1.ph2.noarch
		Installing/Updating: git-2.14.2-1.ph2.x86_64

		Complete!

12. Clone BOC Business Solutions BAMFBeta2 repository
		root@photon-machine [ /usr/local/nodejs ]# git clone https://github.com/bocbusinesssolutions/BAMFBeta2.git
		Cloning into 'BAMFBeta2'...
		remote: Counting objects: 131, done.
		remote: Total 131 (delta 0), reused 0 (delta 0), pack-reused 131
		Receiving objects: 100% (131/131), 3.23 MiB | 1.66 MiB/s, done.
		Resolving deltas: 100% (15/15), done.

13. Start server
		root@photon-machine [ /usr/local/nodejs/BAMFBeta2/BAMF01 ]# node index.js

