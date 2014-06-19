## 项目1：UserHub 开发

### 项目预备知识

#### Form 表单基础
学习视频 [Udactiy Web Development - Forms](https://www.udacity.com/course/viewer#!/c-cs253/l-48736183/m-48734267)，并掌握以下知识点。(时间2小时)

* GET 和 POST 两种表单提交方式的[区别](images/diff-in-get-post.png)
	- GET includes parameters in url and POST includes it in http request body
* 常见的 input 标签的 type 类型
	- text, password, submit
	- checkbox, radio, 
* 掌握 input 标签 
	- value 属性
* 掌握 label 标签
* 掌握 select 和 option 标签 （Dropdowns下拉菜单）
	- value 标签属性 vs content 标签内容 (value wins over content)
* validation 

参考资料： [HyperText Transfer Protocol](http://en.wikipedia.org/wiki/PATCH_(HTTP)#Request_methods)

#### 数据库基础
学习视频 [Storing Data With PostgreSQL](http://www.youtube.com/watch?v=7EzzoULwWx8)，熟悉以下命令。（时间1小时）

* psql 和 psql -d (指定连接的数据库名称)
* help (查看帮助信息)
* CREATE DATABASE data_testing;
* CREATE TABLE users (name varchar(255), movie varchar(255), number int);
* \c data_testing 
* \d 和 \d users (查看数据库中的表)
* SELECT * from users;
* INSERT INTO users (name,movie,number) VALUES('Ben','Braveheart',35);
* SELECT * from users where number > 10;
* DELETE FROM users where id = 2;

参考资料 [postgresql select](http://www.postgresqltutorial.com/postgresql-select/)

#### MVC 设计模式
* [Happycasts: Rails 入门系列视频](http://ruby-china.org/topics/8456)
* [Getting Started with MVC](http://www.sitepoint.com/getting-started-with-mvc/)
* 这个视频讲得很好，但是以前免费，现在要收费了。[Intro to MVC by CodeSchool](https://www.codeschool.com/code_tv/intro-to-mvc)

![A detailed diagram of MVC in Rails](http://railstutorial.org/images/figures/mvc_detailed-full.png)

#### 风格化 Bootstrap Styling
* [twitter-bootstrap-basics](http://railscasts.com/episodes/328-twitter-bootstrap-basics?view=asciicast)
* [Default grid system](http://getbootstrap.com/2.3.2/scaffolding.html)
	- row, span9, span3

#### 闪烁消息 Flash Message
* [Looping Through Flash](http://railscasts.com/episodes/18-looping-through-flash)
* [display flash messages](http://railscasts.com/episodes/329-more-on-twitter-bootstrap)

#### 邮件发送 Sending Email
* [Action Mailer Basics](http://guides.rubyonrails.org/v3.2.14/action_mailer_basics.html)
* [Action Mailer](http://api.rubyonrails.org/classes/ActionMailer/Base.html)
* [sending email](http://railscasts.com/episodes/61-sending-email?autoplay=true)
* [sending html email](http://railscasts.com/episodes/312-sending-html-email?autoplay=true)

### UserHub 项目开发流程
[UserHub Project step by step](https://github.com/limingth/hands-on-rails/blob/master/prj2-user-hub.md)

* step 1: 创建 user controller 来实现登录页面
* step 2: 创建数据库 users 
* step 3: 添加数据库 users 的记录并通过 Rails Console 确认
* step 4: 修改 user controller 并通过页面显示
* step 5: 修改 user view 页面通过表单输入添加用户
* step 6: 风格化 Styling with Bootstrap
* step 7: 修改 edit 和删除 delete 记录
* step 8: 部署到 Heroku 网站 Deploy on heroku
* step 9: 闪烁消息 Flash Message
* step 10: 邮件发送 Sending Email

参考资料 [A demo app](http://ruby.railstutorial.org/chapters/a-demo-app#top)

