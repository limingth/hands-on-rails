## Web 开发基本流程

本节课程学习时间约1周，主要侧重 Git 工具的介绍，并熟悉基本的 Heroku 网站部署流程。

### 什么是 Git？
*- Git 是个什么玩意？ 从来没听说过啊。*

*- 你 out 了，难道没听说，“不知道歌易特，活了也白活”？*

赶紧了解一下吧。[About Git](http://zh.wikipedia.org/zh/Git)

靠，东西太多看不过来？Look this [Git Guide](http://rogerdudler.github.io/git-guide/index.zh.html)

还是看不懂？没关系，看视频总会吧。 [Git 介绍视频](http://gitreal.codeschool.com/levels/1)

#### 体验一下 Git 命令
*- 原来 Git 是这样，听起来还蛮不错的，我自己先试用一下看。*

*- 没问题！Come on！[点击这里在线学习 Git](https://www.codeschool.com/courses/git-real)* 

#### 如何安装 Git？
*- 我已经了解了什么是 Git ，也用过了几个命令，现在我想在自己机器上把它装起来。*

*- 太好了，你真是一个勤奋好学的孩子，那么接下来挑战一下自己吧。试试？[Set up Git](https://help.github.com/articles/set-up-git)*

### GitHub
*- 之前你应该已经注册好了 github 帐号吧？*

*- Sorry，上周偷懒了。我现在[马上注册](https://github.com/)*

#### 课堂练习
*- 大哥，借个火？”*

*- 没带 zip ，你有 repo 吗?*

*- 啥是 repo?*

*- nnd，这都不知道，你还敢出来"结伙"？赶紧的 [Create a repo](https://help.github.com/articles/create-a-repo)*

### Gist
[Gist: Share the history of your writing](http://www.youtube.com/watch?v=EaW_k6jrt2I)

### MarkDown
[Markdown Basics 101](http://www.youtube.com/watch?v=oba3Czjyras)

### Heroku 部署网站

#### Heroku是什么？
Heroku是一个网络服务，你将Rails应用程序上传到Heroku，由Heroku自动将其部署在[亚马逊的EC2](http://zh.wikipedia.org/zh/Amazon_EC2)上。

你不用关心运行环境配置的问题，你只要专注于自己程序实现，其他的事情都交给Heroku来做。

一个不完全确切但形象的比喻，Heroku就是一个使用Ruby的GAE - [Google App Engine](http://zh.wikipedia.org/zh/Google_App_Engine)。

* Heroku 怎么读？
	- HeroKu ，不读 Hero-Ku, 读作 Her-oh-koo ！

* 学习了解更多关于 Heroku  [Getting Started with Heroku](https://devcenter.heroku.com/articles/quickstart) 

* 提前了解 Heroku 不支持 SQLite3 [SQLite on Heroku](https://devcenter.heroku.com/articles/sqlite3)

### Html 基础
* [html 单页面施工七日记](http://haoqicat.com/happypeter/html7)

#### bootstrap
* [bootcss](http://www.bootcss.com/)
* [bootstrap on github repo](https://github.com/twbs/bootstrap)
* [wrapbootstrap](http://wrapbootstrap.com/)
* [hello world on bootstrap](http://v3.bootcss.com/getting-started/)

### Postgresql 数据库

#### 安装 Postgresql
* 了解一下关于[Postgresql](http://zh.wikipedia.org/zh/PostgreSQL)

* 更多关于[Postgresql 网站](http://www.postgresql.org/about/)

* 本地安装和测试 psql [work with psql](https://github.com/limingth/myRoR/blob/master/2-work-with-psql.md)

### 课后大作业
将第一个小节学习的 Rails 网站快速搭建，部署到 Heroku 上，并提交部署完成后的 Internet URL。

页面源码可以参考 [Jumbotron](http://getbootstrap.com/examples/jumbotron/)

* 动手实践 [Host on heroku](https://github.com/limingth/myRoR/blob/master/7-hosting-on-heroku.md) (****)
    - step 1: 本地运行 rails s 可以通过 localhost:3000 浏览页面
    - step 2: 在 github 上创建了项目代码，可以运行 git clone 下载项目代码
    - step 3: 本地安装好 heroku，可以运行 heroku 命令
    - step 4：可以通过 heroku create 和 git push heroku master 完成推送并产生新的域名
    - step 5：可以通过 heroku run rake db:migrate 和 heroku ps 完成启动并浏览新的域名

* 参考资料  
    - [Heroku Dev Center](https://devcenter.heroku.com/)
    - [Getting Started with Rails 4.x on Heroku](https://devcenter.heroku.com/articles/getting-started-with-rails4)


