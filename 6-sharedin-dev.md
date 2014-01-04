## 项目4：SharedIn 社交网站开发


### User Story

### 1. Design Homepage

#### 1.1 New project and welcome page with bootstrap styling

* new project sharedin.us

    `rails new sharedin.us`
    
* welcome page

    `rails generate controller welcome index`

* bootstrap styling

    `rails generate bootstrap:install`

* git commit 

    `git commit -a -m "new project and welcome page with bootstrap styling"`

#### 1.2 Layout application

* https://www.linkedin.com

    `cp index.html app/view/welcome/index.html.erb`

* add navbar layout

    `vi app/views/layouts/application.html.erb`

* puts top-padding on the body element
    
    `vi app/assets/stylesheets/bootstrap_and_overrides.css.less`

* add left sidebar layout  

* add welcome message

* add bottom bar layout 

* generate controller uas nhome pub

    `rails generate controller uas`
    `rails generate controller nhome create`
    `rails generate controller pub dir`


#### 1.3 Deploy on heroku

* test heroku deployment 

    `heroku create`
    `git push heroku master`

* change Sqlite3 to Postgresql

    `vi Gemfile`
    `vi config/database.yml`
    `git commit -a -m "Change db from sqlite3 to postgresql for heroku deployment"`

* create db 

    `rake db:create`

* name site as sharedin-us

    `heroku create sharedin-us`
    `git push heroku master`



