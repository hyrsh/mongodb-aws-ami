#Simple MongoDB install script for AWS AMI VMs

This is a single node setup for MongoDB on Amazon AMI virtual machines. Just run the script as privileged user.

#Usage on a fresh machine

- sudo yum install git -y
- sudo git clone https://github.com/hyrsh/mongodb-aws-ami
- cd mongodb-aws-ami
- sudo ./01_install.sh

Relog to your machine with SSH port 20234 and type 'mongolog' to see MongoDB logs for further information.
