## 项目4：SharedIn 社交网站开发


### User Story

### 1. Homepage Design

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

* add navbar layout

    `vi app/views/layouts/application.html.erb`

* https://www.linkedin.com
    `cp index.html app/view/welcome/index.html.erb`

* puts top-padding on the body element
    
    `vi app/assets/stylesheets/bootstrap_and_overrides.css.less`

* add left sidebar layout  

* add welcome message

* add bottom bar layout 


