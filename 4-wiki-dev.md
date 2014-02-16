## 项目2：类 Wiki 博客网站开发

### 项目预备知识

* 用户模型 User Model 
	- 迁移文件 Data migration
	- 控制台 rails console
	- Active Record
	- 验证存在性 validates
	- 唯一性 uniqueness

* 路由概念 Route 
	- Users 资源对应的路由
	- users_path
	- new_user_path
	- edit_user_path(user)

* 页面布局 Layout 
	- shared 目录
	- render 渲染局部视图

* Sessions 控制器
	- 设置路由关系
	- SessionsHelper 模块
	- session 函数
	- current_user

* Ruby 提高
	- Seed 概念
	- Hash 初始化 
	- form_for 生成表单代码
	- link_to

#### 参考资料: 
* [《Ruby on Rails Tutorial》- Modeling users](http://ruby.railstutorial.org/chapters/modeling-users#top)
* [《Ruby on Rails 教程》中文翻译版](http://railstutorial-china.org/chapter6.html)
* [PostgreSQL INNER JOIN](http://www.postgresqltutorial.com/postgresql-inner-join)
* [Sign up and password](http://www.youtube.com/watch?v=bOdn9EdUquo&feature=youtu.be)

### 类 Wiki 项目开发流程

* [Create the Wikiful Rails App](https://github.com/limingth/myRoR/blob/master/1-build-project-wikiful.md)
	- Create the Wikiful Landing Page
	- Push Your Local Repository up to Github

* [The ActiveRecord ORM and Models in Rails](https://github.com/limingth/myRoR/blob/master/2-work-with-psql.md)
	- Configure Rails to Work with PostgreSQL
	- Modeling Articles, Categories, and Users for Wikiful
	- Seed Your Data
 
* [Connecting the Thread for Wikiful](https://github.com/limingth/myRoR/blob/master/3-connect-thread-with-mvc.md)
	- Connect the Thread for Articles
	- Getting Your Model Data into Article Views
	- Letting Users Write and Publish Articles
	- Index and Show View for Categories
	- Model-View-Controller interactive 
	- A Better Welcome Page

* [Layout and Styling with Twitter Bootstrap](https://github.com/limingth/myRoR/blob/master/4-style-wikiful-with-twitter-bootstrap.md)
	- Adding Bootstrap
	- Base Application Layout
	- Checkout Twitter-Bootstrap-Rails Scaffolding

* [User Authentication](https://github.com/limingth/myRoR/blob/master/6-user-authentication.md)
	- Create the User Model and Sign Up Flow
	- Create Sessions, Login/Logout, and Authorization Flow
	- improve our routes
	- automatically sign in users after they sign up for an account

* Gravatar 用户头像 
	- gravatar_for
 

### 参考资料: 

* [《Beginning Rails 4》, 3rd Edition](http://it-ebooks.info/book/3030/)
	- [Working with a Database: Active Record](http://books.google.com/books?id=KdvTAAAAQBAJ&pg=PA61&dq=“Working+with+a+Database”+rails&hl=zh-CN&sa=X&ei=fxPjUrHuH9HwoATkp4KYCw&ved=0CC8Q6AEwAA#v=onepage&q=“Working%20with%20a%20Database”%20rails&f=false)
