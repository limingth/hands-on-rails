
# how-to-install-rails-on-ubuntu-14.04

##1 git and ruby
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
  
##2 rails

* https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-on-ubuntu-14-04-using-rvm

### install rails
    \curl -sSL https://get.rvm.io | bash -s stable --rails

#### check rails version after installation
    ubuntu@ip-172-31-2-44:~$ rails -v
    Rails 4.1.1

##3 postgresql

* https://help.ubuntu.com/community/PostgreSQL

### install postgresql
    sudo apt-get -y install postgresql-9.3
    sudo apt-get -y install postgresql-server-dev-9.3 
     
#### check psql after installation
    $ sudo -u postgres psql postgres
    psql (9.3.4)
    Type "help" for help.
    
    postgres=# \password postgres
    (input maodou)
    
    $ sudo -u postgres createdb mydb
    $ sudo -u postgres psql
    psql (9.3.4)
    Type "help" for help.
    
    postgres=# \h
    postgres=# \list
                                      List of databases
       Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges   
    -----------+----------+----------+-------------+-------------+-----------------------
     mydb      | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
     postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
     template0 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
               |          |          |             |             | postgres=CTc/postgres
     template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
               |          |          |             |             | postgres=CTc/postgres
    (4 rows)
    
## bundle install

### install pg
    $ gem install pg 
    $ bundle install
    $ gem install rdoc-data; rdoc-data --install
    
### create user ubuntu and alter role
    $ rails server
    FATAL: role "ubuntu" does not exist
    $ sudo -u postgres createuser ubuntu
    $ sudo -u postgres psql -c 'alter user ubuntu with createdb' postgres
    
    ubuntu@ip-172-31-2-44:~/Github/UserHub$ sudo -u postgres createuser ubuntu
    createuser: creation of new role failed: ERROR:  role "ubuntu" already exists
    ubuntu@ip-172-31-2-44:~/Github/UserHub$ sudo -u postgres psql -c 'alter user ubuntu with createdb' postgres
    ALTER ROLE
    ubuntu@ip-172-31-2-44:~/Github/UserHub$ createdb
    
### create db
    $ rake db:create
    $ rake db:migrate

### rails server
    $ rails server
   
* http://54.183.64.52:3000/
    
