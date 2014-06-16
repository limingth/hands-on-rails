
# how-to-install-rails-on-ubuntu-14.04

## git and ruby
* http://askubuntu.com/questions/452243/what-versions-of-ruby-are-supported-in-14-04

### install git
    sudo apt-get -y install git-core curl
    
### install ruby2.1
    sudo add-apt-repository ppa:brightbox/ruby-ng
    sudo apt-get update
    sudo apt-get -y install ruby2.1

#### check ruby version after installation
    ubuntu@ip-172-31-2-44:~$ ruby -v
    ruby 2.1.2p95 (2014-05-08 revision 45877) [x86_64-linux-gnu]
  
## rails

* https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-on-ubuntu-14-04-using-rvm

### install rails
    \curl -sSL https://get.rvm.io | bash -s stable --rails

#### check rails version after installation
    ubuntu@ip-172-31-2-44:~$ rails -v
    Rails 4.1.1

## postgresql

* https://help.ubuntu.com/community/PostgreSQL

### install postgresql
    sudo apt-get -y install postgresql-9.3
    
#### check psql after installation
    $ sudo -u postgres psql postgres
    psql (9.3.4)
    Type "help" for help.
    
    postgres=# \password postgres
    (input maodou)
    
