
# Prj1 - My First App on Heroku

step 1: 本地运行 rails s 可以通过 localhost:3000 浏览页面
------------------------------------------------------

### New a project
* rails new my-first-app
* cd my-first-app/
* bundle install

### Modify route of root 
* vi config/routes.rb 
* chrome http://localhost:3000/

### Add welcome controller with index method
* rails g controller welcome index
* chrome http://localhost:3000/

### Modify index.html.erb
* vi app/views/welcome/index.html.erb 
* refer to http://v3.bootcss.com/getting-started/


step 2: 在 github 上创建了项目代码，可以运行 git clone 下载项目代码
------------------------------------------------------

### Create a new repo after log in github.com
* https://github.com/new
* name the new repo as my-first-app
* click create repository

### Git clone the new repo in a second Terminal
* git clone http://github.com/limingth/my-first-app.git
	- fatal: destination path 'my-first-app' already exists and is not an empty directory.
* mv my-first-app/ my-tmp-app
* git clone git@github.com:limingth/my-first-app.git
* cd my-first-app/
* cp -R ../my-tmp-app/* .
* ls

### Git push the rails files to github repo
* git add .
* git commit -a -m "Add all rails files"
* git push


step 3: 本地安装好 heroku，可以运行 heroku login 命令
------------------------------------------------------

### Install heroku
* if heroku not installed, refer to https://toolbelt.heroku.com/
	- install heroku toolbelt

### Managing Your SSH Keys
* ssh-keygen -t rsa
* heroku keys:add
* refer to https://devcenter.heroku.com/articles/keys

### Verify heroku command
* heroku 
* heroku help

### Heroku login
* heroku login 
	- Enter your Heroku credentials.
	- Email: limingth@gmail.com
	- Password (typing will be hidden): 


step 4：可以通过 heroku create 产生随机域名和 git push heroku master 完成推送
------------------------------------------------------

### heroku create
* heroku create
	- get the link like http://polar-oasis-1107.herokuapp.com/
	- git config -e if you like it
* git push heroku master
	- push the repo from local git to heroku host
* get error message
	- An error occurred while installing sqlite3 (1.3.8), and Bundler cannot continue.

### Delete gem 'sqlite3' since heroku doesn't support it and add gem 'pg'
* vi Gemfile
	- comment: #gem 'sqlite3'
	- add: gem 'pg'
* bundle install

### Git push Again
* git status
* git add .
* git commit -a -m "M Gemfile to uncomment gem sqlite3"
* git push 
* git push heroku master (AGAIN)
* get no error message this time and you can find this
	- To git@heroku.com:polar-oasis-1107.git
	- * [new branch]      master -> master

### Verify the new app on heroku is working now
* chrome http://polar-oasis-1107.herokuapp.com
	- you can see the domain is alive on heroku now 


step 5：可以通过 heroku run rake db:migrate 生成数据库和 heroku create a-new-name 产生新的域名
------------------------------------------------------

### Migrate database 
* heroku run rake db:migrate
	- Running `rake db:migrate` attached to terminal... up, run.4921

### Change a good name for your website
* heroku create first-site-of-limingth
	- be carefule with the name, only with lowercase letters, numbers, and dashes.

* git config -e
	- make sure that in [remote "heroku"]
	- url = git@heroku.com:first-site-of-limingth.git
	- this shoule be the same with your website name

* git push heroku master 
	- push it again to heroku.com 



	
