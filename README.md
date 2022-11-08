# Simple MongoDB install script for AWS AMI VMs

This is a single node setup for MongoDB on Amazon AMI virtual machines. Just run the script as privileged user.

# Usage on a fresh machine

- sudo yum install git -y
- sudo git clone https://github.com/hyrsh/mongodb-aws-ami
- cd mongodb-aws-ami
- sudo ./01_install.sh

Relog to your machine with SSH port 20234 and type 'mongolog' to see MongoDB logs for further information.

# Further information

The compatability version of AMI V2 is RedHat/CentOS 7.

If you start a MongoDB just like this it runs with default a configuration provided by the MongoDB team. To make it available you must change the config at /etc/mongod.conf and restart the service with 'systemctl restart mongod'.

Be aware that making your database available requires a change in your AWS security groups.

Exposing your database without respective protection (SCRAM, x509, LDAP + limited network access) makes you the king of all fools.
