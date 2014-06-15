
# How to use AWS

## Create an uBuntu Virtual Machine on AWS

### Register on aws.amazon.com

### Create an instance of uBuntu 14.04

### Connect to uBuntu using SSH
    chmod 400 pplinux.pem 
    ssh -i pplinux.pem ubuntu@54.183.64.52

### Install all services
    ubuntu@ip-172-31-2-44:~$ pwd
    /home/ubuntu
    ubuntu@ip-172-31-2-44:~$ sudo apt-get install vnc4server
