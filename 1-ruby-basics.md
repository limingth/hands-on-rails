## Ruby 语言基础

本节课程学习时间约1周，建议强化编程练习部分，并独立完成课后大作业。

### 什么是 Ruby？
* [点击视频观看学习](http://www.lynda.com/home/Player.aspx?lpk4=57937&playChapter=False)

### 体验一下 Ruby 编程
* [在线学习Ruby语言](http://tryruby.org/levels/1/challenges/0)

### Ruby 编程练习
先学习一下 ivb 的用法，观看视频 

* [IRB and Your First Ruby Program](http://teamtreehouse.com/library/ruby-foundations/ruby-basics/irb-and-your-first-ruby-program)

* [Ruby programming course](http://vimeo.com/21010874)

完成以下的9个代码练习，可以先抄写三遍，然后自己独立实现一遍。

提示：可以用 diff 命令比较文件差别

* [熟悉 Unit 基本命令进行文件目录操作](http://people.ischool.berkeley.edu/~kevin/unix-tutorial/section4.html)

* 注释写法  
<https://github.com/limingth/myRoR/blob/master/NCRoR/1.rb>

* 打印输出  
<https://github.com/limingth/myRoR/blob/master/NCRoR/2.rb>

* while 循环  
<https://github.com/limingth/myRoR/blob/master/NCRoR/3.rb>

* if 条件判断  
<https://github.com/limingth/myRoR/blob/master/NCRoR/4.rb>

* for 循环  
<https://github.com/limingth/myRoR/blob/master/NCRoR/5.rb>

* 两重循环  
<https://github.com/limingth/myRoR/blob/master/NCRoR/6.rb>

* for-if 逻辑组合  
<https://github.com/limingth/myRoR/blob/master/NCRoR/7.rb>

* 函数设计  
<https://github.com/limingth/myRoR/blob/master/NCRoR/8.rb>

* 输入输出  
<https://github.com/limingth/myRoR/blob/master/NCRoR/9.rb>

* 学习 [Ruby 数组](http://www.ruby-doc.org/core-2.1.0/Array.html) 的知识

* 掌握 [Ruby Ranges](http://www.techotopia.com/index.php/Ruby_Ranges) 的用法

#### Ruby 参考教材
* [Ruby tutorial](http://www.tutorialspoint.com/ruby)

### 课后大作业
* 约瑟夫环问题  
已知n个人（以编号1，2，3...n分别表示）围坐在一张圆桌周围。
从编号为k的人开始报数，数到m的那个人出列；
他的下一个人又从1开始报数，数到m的那个人又出列；
依此规律重复下去，直到圆桌周围的人全部出列。

* [问题详细描述](http://zh.wikipedia.org/wiki/%E7%BA%A6%E7%91%9F%E5%A4%AB%E6%96%AF%E9%97%AE%E9%A2%98)
* [参考C程序设计](https://github.com/limingth/NCCL/blob/master/Unit-1/Lesson-10.md)

### 开源项目
* 网络爬虫  
参考开源项目 [rubycrawler](https://github.com/limingth/hands-on-rails/tree/master/rubycrawler), 阅读代码并理解以下技术要点：
	- 学会栈的设计
	- 区分全局变量和局部变量
	- 了解正则表达式的基本概念
	- 掌握 open-uri 库的用法
	- 掌握 ruby class 类的实现
	- 函数的接口设计、传参和返回值
	- 程序设计方法和设计模式

* 增添新的功能  
目前已完成在一个网站内部页面的抓取和解析，请实现对外部网站的链接抓取，并记录全部抓取过的页面和抓取结果。
