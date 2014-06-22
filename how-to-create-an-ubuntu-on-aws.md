
# How to use AWS

## Create an uBuntu Virtual Machine on AWS

### Register on aws.amazon.com

### Create an instance of uBuntu 14.04 in ec2
* https://console.aws.amazon.com/ec2/v2/home?region=us-west-1

### Connect to uBuntu using SSH
    chmod 400 pplinux.pem 
    ssh -i pplinux.pem ubuntu@54.183.64.52

### Change security group on AWS
* All security groups
* ping 54.183.64.52

### Install vnc4server
    ubuntu@ip-172-31-2-44:~$ pwd
    /home/ubuntu
    ubuntu@ip-172-31-2-44:~$ sudo apt-get install vnc4server

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

