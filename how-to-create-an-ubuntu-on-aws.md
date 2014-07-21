
# How to use AWS

## Create an uBuntu Virtual Machine on AWS

### Register on aws.amazon.com
* provide your credit card info, no worry, trust me.

### Create an instance of uBuntu 12.04 in ec2
* https://console.aws.amazon.com/ec2/v2/home
* Select your region at right-top corner
  - Asia Pacific (Singapore)
  - US West (N. California)
* Launch Instance (Free tier only)
  - Community AMIs (Ubuntu + 64-bit + EBS)
  - ubuntu/images/ebs/ubuntu-precise-12.04-amd64-server-20130527 - ami-085b155a

### Lauch your instance
* Select create a pair key

### Change security group on AWS
* All security groups -> inbound -> Custom IP -> Anywhere 
* ping 54.183.64.52

### Connect to uBuntu using SSH
    chmod 400 pplinux.pem 
    ssh -i pplinux.pem ubuntu@54.254.139.77

### Install vnc4server
    ubuntu@ip-172-31-2-44:~$ pwd
    /home/ubuntu
    ubuntu@ip-172-31-2-44:~$ sudo apt-get update
    ubuntu@ip-172-31-2-44:~$ sudo apt-get install vnc4server -y

### VNC viewer to test
* connect and you will see a shell

#### Original xstartup in /home/ubuntu/.vnc/xstartup
    #!/bin/sh
    
    # Uncomment the following two lines for normal desktop:
    # unset SESSION_MANAGER
    # exec /etc/X11/xinit/xinitrc
    
    [ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
    [ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
    xsetroot -solid grey
    vncconfig -iconic &
    x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
    x-window-manager &
    ~           
    
### Install gnome desktop on 12.04
    ubuntu@ip-172-31-2-44:~$ sudo apt-get install gnome-core
    ubuntu@ip-172-31-2-44:~$ sudo apt-get install ubuntu-gnome-desktop 
    ubuntu@ip-172-31-2-44:~$ sudo apt-get install gnome
    
### Minimal Gnome Core Desktop on 14.04
    ubuntu@ip-172-31-2-44:~$ sudo apt-get install xorg gnome-core gnome-system-tools gnome-app-install
    ubuntu@ip-172-31-2-44:~$ sudo apt-get install xfce4

* http://www.htpcbeginner.com/install-gui-on-ubuntu-server-14-04-gnome/

#### Modify xstartup
    ubuntu@ip-172-31-2-44:~/.vnc$ cat xstartup
    #!/bin/sh
    unset SESSION_MANAGER
    unset DBUS_SESSION_BUS_ADDRESS
    startxfce4 &
    
    [ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
    [ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
    xsetroot -solid grey
    vncconfig -iconic &

* http://askubuntu.com/questions/452497/14-04-vnc-xstartup-file

### Some problem very faint
* Terminal all black
    - change profile the color
* Key 's' and 'd' can not input
    - gsettings reset org.gnome.desktop.wm.keybindings panel-main-menu
* change user ubuntu password
    - sudo vi /etc/shadow  
    - delete ! between first : and second :    (ubuntu::16237:0:99999:7:::)
* tab can not complete
    - http://ubuntuforums.org/archive/index.php/t-1771058.html
    - line 112:       <property name="&lt;Super&gt;Tab" type="empty"/>

### Install git
    ubuntu@ip-172-31-2-44:~$ sudo apt-get install git

### Add swap vm to ubuntu
https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-12-04

    ubuntu@ip-172-31-3-33:~/KeyBox-jetty$ sudo swapon -s
    Filename				Type		Size	Used	Priority
    ubuntu@ip-172-31-3-33:~/KeyBox-jetty$ sudo dd if=/dev/zero of=/swapfile bs=1024 count=512k
    524288+0 records in
    524288+0 records out
    536870912 bytes (537 MB) copied, 14.6051 s, 36.8 MB/s
    ubuntu@ip-172-31-3-33:~/KeyBox-jetty$ sudo mkswap /swapfile
    Setting up swapspace version 1, size = 524284 KiB
    no label, UUID=74eea1ba-6a37-40c5-bda3-de7e4a5fb5ad
    ubuntu@ip-172-31-3-33:~/KeyBox-jetty$ sudo swapon /swapfile
    ubuntu@ip-172-31-3-33:~/KeyBox-jetty$ sudo swapon -s
    Filename				Type		Size	Used	Priority
    /swapfile                               file		524284	0	-1
    ubuntu@ip-172-31-3-33:~/KeyBox-jetty$ sudo nano /etc/fstab
    ubuntu@ip-172-31-3-33:~/KeyBox-jetty$ cat /etc/fstab
    LABEL=cloudimg-rootfs	/	 ext4	defaults	0 0
    /swapfile       none    swap    sw      0       0 
    ubuntu@ip-172-31-3-33:~/KeyBox-jetty$ echo 10 | sudo tee /proc/sys/vm/swappiness
    10
    ubuntu@ip-172-31-3-33:~/KeyBox-jetty$ echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf
    vm.swappiness = 10
    ubuntu@ip-172-31-3-33:~/KeyBox-jetty$ sudo chown root:root /swapfile 
    ubuntu@ip-172-31-3-33:~/KeyBox-jetty$ sudo chmod 0600 /swapfile
    ubuntu@ip-172-31-3-33:~/KeyBox-jetty$ 

### Change SSH login to PasswordAuthentication
    
    # Change to no to disable tunnelled clear text passwords
    #PasswordAuthentication no
    UseDNS no
    AddressFamily inet
    PasswordAuthentication yes
