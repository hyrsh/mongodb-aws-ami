#!/bin/bash

#path to ssh config
sshcfg=/etc/ssh/sshd_config

#ssh port to change to
hport=$(grep "SSHPORT" ./config.cfg | awk -F= '{print $2}')

#mongodb yum target
mongodbrepo=/etc/yum.repos.d/mongodb-org-6.0.repo

#compatability version to mongodb on ami
ver=$(grep "compatability_version" ./config.cfg | awk -F= '{print $2}')




sed -i "s/#Port 22/Port $hport/g" $sshcfg

echo -e "\e[36;1mChanged SSH port from 22 to 20234\e[0;0m"

systemctl restart sshd.service

echo -e "\e[33;1mRestarted SSH service. Reconnect on port 20234!\e[0;0m"

echo -e "\e[36;1mUpdated YUM repository file!\e[0;0m"

cat ./mongodb.repo | sed "s/AMIVERSIONCOMP/$ver/g" > $mongodbrepo

yum install mongodb-org -y

echo '#!/bin/bash' > /etc/profile.d/mongologs.sh
echo "alias mongolog='less /var/log/mongodb/mongod.log'" >> /etc/profile.d/mongologs.sh

prettyformat='cat /var/log/mongodb/mongod.log | awk -F, "{print \$3\"\t\"\$6 \$7}" | sed -e "s/\"c\"://g" -e "s/\"msg\"://g" | tail -100'

echo '#!/bin/bash' > /etc/profile.d/prettymongo.sh
echo -n "alias prettymo='" >> /etc/profile.d/prettymongo.sh
echo -n "$prettyformat" >> /etc/profile.d/prettymongo.sh
echo -n "'" >> /etc/profile.d/prettymongo.sh

. /etc/profile.d/mongologs.sh
. /etc/profile.d/prettymongo.sh

systemctl enable mongod
systemctl start mongod

echo -e "\e[36;1mStarted and enabled MongoDB!\e[0;0m"
echo -e "\e[36;1mSee full logs by typing 'mongolog'\e[0;0m"
echo -e "\e[36;1mSee 100 line pretty logs by typing 'prettymo'\e[0;0m"
