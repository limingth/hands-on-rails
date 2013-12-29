# rubycrawler

## ruby crawler is a project for searching emails in a website

### test the crawler for one page
	limingth@gmail ~/Github/hands-on-rails/rubycrawler$ make
	./mycrawler.rb
	www.akaedu.us
	2013-12-29 11:54:49 -0800_www.akaedu.us.dat

	--- 0 page crawling
	@ pop 1  http://www.akaedu.us
	  try open http://www.akaedu.us
	  open and read ok
	+ add email: info.ch@itu.edu
	+ add email: enroll@akaedu.us
	^ push crawled 1 http://www.akaedu.us
	2013-12-29 11:54:49 -0800_www.akaedu.us.dat
	limingth@gmail ~/Github/hands-on-rails/rubycrawler$ 

### test the crawler for multi pages
	limingth@gmail ~/Github/hands-on-rails/rubycrawler$ make
	./mycrawler.rb
	www.akaedu.org
	2013-12-29 11:33:21 -0800_www.akaedu.org.dat

	--- 0 page crawling
	@ pop 1  http://www.akaedu.org
	  try open http://www.akaedu.org
	  open and read ok
	+ add email: advice@akaedu.org
	+ add email: wh2002lyglb@hotmail.com
	+ add email: akaedu005@hotmail.com
	+ add email: akaedu007@hotmail.com
	^ push crawled 1 http://www.akaedu.org

	-> find url: http://www.akaedu.org
	x has been crawled

	-> find url: http://www.akaedu.org/pages/about04.php
	^ push stack 1 http://www.akaedu.org/pages/about04.php 1

	-> find url: http://www.akaedu.org/pages/about01.htm
	^ push stack 2 http://www.akaedu.org/pages/about01.htm 1

	-> find url: http://www.akaedu.org/pages/team01.htm
	^ push stack 3 http://www.akaedu.org/pages/team01.htm 1

	-> find url: http://www.akaedu.org/page/zyindex.php
	^ push stack 4 http://www.akaedu.org/page/zyindex.php 1

	-> find url: http://www.akaedu.org/pages/ask01.htm
	^ push stack 5 http://www.akaedu.org/pages/ask01.htm 1

	-> find url: http://www.akaedu.org/pages/about04.php
	x already in links_stack

	-> find url: http://www.akaedu.org/pages/center07.php
	^ push stack 6 http://www.akaedu.org/pages/center07.php 1

	-> find url: http://www.akaedu.org/page/news2.php
	^ push stack 7 http://www.akaedu.org/page/news2.php 1

	-> find url: http://www.akaedu.org/pages/about01.htm
	x already in links_stack

	-> find url: http://www.akaedu.org/pages/about01.htm
	x already in links_stack

	-> find url: http://www.akaedu.org/pages/center05.htm
	^ push stack 8 http://www.akaedu.org/pages/center05.htm 1

	-> find url: http://www.akaedu.org/pages/contact02.htm
	^ push stack 9 http://www.akaedu.org/pages/contact02.htm 1

	-> find url: http://www.akaedu.org/page/cert.php
	^ push stack 10 http://www.akaedu.org/page/cert.php 1

	-> find url: http://www.akaedu.org/pages/about03.htm
	^ push stack 11 http://www.akaedu.org/pages/about03.htm 1

	-> find url: http://www.akaedu.org/pages/center04.htm
	^ push stack 12 http://www.akaedu.org/pages/center04.htm 1

	-> find url: http://www.akaedu.org/pages/center04.htm
	x already in links_stack

	-> find url: http://www.akaedu.org/pages/center01.htm
	^ push stack 13 http://www.akaedu.org/pages/center01.htm 1

	-> find url: http://www.akaedu.org/pages/center05.htm
	x already in links_stack

	-> find url: http://www.akaedu.org/pages/protect01.htm
	^ push stack 14 http://www.akaedu.org/pages/protect01.htm 1

	-> find url: http://www.akaedu.org/pages/center07.php
	x already in links_stack

	-> find url: http://www.akaedu.org/pages/center07.php
	x already in links_stack

	-> find url: http://www.akaedu.org/pages/eva02_1.htm
	^ push stack 15 http://www.akaedu.org/pages/eva02_1.htm 1

	-> find url: http://www.akaedu.org/page/jobnews.php
	^ push stack 16 http://www.akaedu.org/page/jobnews.php 1

	-> find url: http://www.akaedu.org/pages/center08.htm
	^ push stack 17 http://www.akaedu.org/pages/center08.htm 1

	-> find url: http://www.akaedu.org/page/course-973.html
	^ push stack 18 http://www.akaedu.org/page/course-973.html 1

	-> find url: http://www.akaedu.org/pages/anli.html
	^ push stack 19 http://www.akaedu.org/pages/anli.html 1

	-> find url: http://www.akaedu.org/page/tlist.php
	^ push stack 20 http://www.akaedu.org/page/tlist.php 1

	-> find url: http://www.akaedu.org/page/dqindex.php
	^ push stack 21 http://www.akaedu.org/page/dqindex.php 1

	-> find url: http://www.akaedu.org/pages/contact05.php
	^ push stack 22 http://www.akaedu.org/pages/contact05.php 1

	-> find url: http://www.akaedu.org/pages/team01.htm
	x already in links_stack

	-> find url: http://www.akaedu.org/pages/team01.htm
	x already in links_stack

	-> find url: http://www.akaedu.org/page/team.php
	^ push stack 23 http://www.akaedu.org/page/team.php 1

	-> find url: http://www.akaedu.org/pages/team03.htm
	^ push stack 24 http://www.akaedu.org/pages/team03.htm 1

	-> find url: http://www.akaedu.org/page/zyindex.php
	x already in links_stack

	-> find url: http://www.akaedu.org/page/zyindex.php
	x already in links_stack

	-> find url: http://www.akaedu.org/page/zyindex.php
	x already in links_stack

	-> find url: http://www.akaedu.org/page/zyindex.php
	x already in links_stack

	-> find url: http://www.akaedu.org/page/newsdetail-608.html
	^ push stack 25 http://www.akaedu.org/page/newsdetail-608.html 1

	-> find url: http://www.akaedu.org/aka/xyx.php
	^ push stack 26 http://www.akaedu.org/aka/xyx.php 1

	-> find url: http://www.akaedu.org/pages/classroom.php
	^ push stack 27 http://www.akaedu.org/pages/classroom.php 1

	-> find url: http://www.akaedu.org/pages/ask01.htm
	x already in links_stack

	-> find url: http://www.akaedu.org/pages/ask02.htm
	^ push stack 28 http://www.akaedu.org/pages/ask02.htm 1

	-> find url: http://www.akaedu.org/pages/ask03.htm
	^ push stack 29 http://www.akaedu.org/pages/ask03.htm 1

	-> find url: http://www.akaedu.org/pages/ask05.php
	^ push stack 30 http://www.akaedu.org/pages/ask05.php 1

	-> find url: http://www.akaedu.org/pages/ask06.htm
	^ push stack 31 http://www.akaedu.org/pages/ask06.htm 1

	-> find url: http://www.akaedu.org/pages/contact02.htm
	x already in links_stack

	-> find url: http://www.akaedu.org/pages/contact04.htm
	^ push stack 32 http://www.akaedu.org/pages/contact04.htm 1

	-> find url: http://www.akaedu.org/pages/anli.html
	x already in links_stack

	-> find url: http://www.akaedu.org/pages/jiuye.php
	^ push stack 33 http://www.akaedu.org/pages/jiuye.php 1

	-> find url: http://www.akaedu.org/page/video-756.html
	^ push stack 34 http://www.akaedu.org/page/video-756.html 1

	-> find url: http://www.akaedu.org/pages/28.html
	^ push stack 35 http://www.akaedu.org/pages/28.html 1

	-> find url: http://www.akaedu.org/page/book-1010.html
	^ push stack 36 http://www.akaedu.org/page/book-1010.html 1

	-> find url: http://www.akaedu.org/page/book-1011.html
	^ push stack 37 http://www.akaedu.org/page/book-1011.html 1

	-> find url: http://www.akaedu.org/page/book-1012.html
	^ push stack 38 http://www.akaedu.org/page/book-1012.html 1

	-> find url: http://www.akaedu.org/page/book-1013.html
	^ push stack 39 http://www.akaedu.org/page/book-1013.html 1

	-> find url: http://www.akaedu.org/page/book-1014.html
	^ push stack 40 http://www.akaedu.org/page/book-1014.html 1

	-> find url: http://www.akaedu.org/page/zyindex.php
	x already in links_stack

	-> find url: http://www.akaedu.org/page/video-761.html
	^ push stack 41 http://www.akaedu.org/page/video-761.html 1

	-> find url: http://www.akaedu.org/page/video-762.html
	^ push stack 42 http://www.akaedu.org/page/video-762.html 1

	-> find url: http://www.akaedu.org/page/video-763.html
	^ push stack 43 http://www.akaedu.org/page/video-763.html 1

	-> find url: http://www.akaedu.org/page/video-764.html
	^ push stack 44 http://www.akaedu.org/page/video-764.html 1

	-> find url: http://www.akaedu.org/page/video-765.html
	^ push stack 45 http://www.akaedu.org/page/video-765.html 1

	-> find url: http://www.akaedu.org/page/team.php
	x already in links_stack

	-> find url: http://www.akaedu.org/page/team.php
	x already in links_stack

	-> find url: http://www.akaedu.org/page/team.php
	x already in links_stack

	-> find url: http://www.akaedu.org/pages/qrsgcspx.htm
	^ push stack 46 http://www.akaedu.org/pages/qrsgcspx.htm 1

	-> find url: http://www.akaedu.org/page/team.php
	x already in links_stack

	-> find url: http://www.akaedu.org/pages/wqkgj.htm
	^ push stack 47 http://www.akaedu.org/pages/wqkgj.htm 1

	-> find url: http://www.akaedu.org/page/team.php
	x already in links_stack

	-> find url: http://www.akaedu.org/page/newsdetail-2660.html
	^ push stack 48 http://www.akaedu.org/page/newsdetail-2660.html 1

	-> find url: http://www.akaedu.org/page/newsdetail-2590.html
	^ push stack 49 http://www.akaedu.org/page/newsdetail-2590.html 1

	-> find url: http://www.akaedu.org/page/newsdetail-2622.html
	^ push stack 50 http://www.akaedu.org/page/newsdetail-2622.html 1

	-> find url: http://www.akaedu.org/page/newsdetail-2596.html
	^ push stack 51 http://www.akaedu.org/page/newsdetail-2596.html 1

	-> find url: http://www.akaedu.org/page/newsdetail-2595.html
	^ push stack 52 http://www.akaedu.org/page/newsdetail-2595.html 1

	-> find url: http://www.akaedu.org/page/newsdetail-2593.html
	^ push stack 53 http://www.akaedu.org/page/newsdetail-2593.html 1

	-> find url: http://www.akaedu.org/page/newsdetail-2592.html
	^ push stack 54 http://www.akaedu.org/page/newsdetail-2592.html 1

	-> find url: http://www.akaedu.org/page/newsdetail-2591.html
	^ push stack 55 http://www.akaedu.org/page/newsdetail-2591.html 1

	-> find url: http://www.akaedu.org/page/newsdetail-2637.html
	^ push stack 56 http://www.akaedu.org/page/newsdetail-2637.html 1

	-> find url: http://www.akaedu.org/page/newsdetail-2621.html
	^ push stack 57 http://www.akaedu.org/page/newsdetail-2621.html 1

	-> find url: http://www.akaedu.org/page/newsdetail-2597.html
	^ push stack 58 http://www.akaedu.org/page/newsdetail-2597.html 1

	-> find url: http://www.akaedu.org/page/newsdetail-2492.html
	^ push stack 59 http://www.akaedu.org/page/newsdetail-2492.html 1

	-> find url: http://www.akaedu.org/page/newsdetail-2488.html
	^ push stack 60 http://www.akaedu.org/page/newsdetail-2488.html 1

	-> find url: http://www.akaedu.org/page/newsdetail-2484.html
	^ push stack 61 http://www.akaedu.org/page/newsdetail-2484.html 1

	-> find url: http://www.akaedu.org/page/newsdetail-2480.html
	^ push stack 62 http://www.akaedu.org/page/newsdetail-2480.html 1

	-> find url: http://www.akaedu.org/page/newsdetail-2450.html
	^ push stack 63 http://www.akaedu.org/page/newsdetail-2450.html 1

	-> find url: http://www.akaedu.org/page/newsdetail-1042.html
	^ push stack 64 http://www.akaedu.org/page/newsdetail-1042.html 1

	-> find url: http://www.akaedu.org/page/newsdetail-1042.html
	x already in links_stack

	-> find url: http://www.akaedu.org/page/newsdetail-643.html
	^ push stack 65 http://www.akaedu.org/page/newsdetail-643.html 1

	-> find url: http://www.akaedu.org/pages/eva02_1.htm
	x already in links_stack

	-> find url: http://www.akaedu.org/aka/xyx.php
	x already in links_stack

	-> find url: http://www.akaedu.org/aka/xyx.php
	x already in links_stack

	-> find url: http://www.akaedu.org/aka/xyx.php
	x already in links_stack

	-> find url: http://www.akaedu.org/aka/xyx.php
	x already in links_stack

	-> find url: http://www.akaedu.org/aka/xyx.php
	x already in links_stack

	-> find url: http://www.akaedu.org/aka/xyx.php
	x already in links_stack

	-> find url: http://www.akaedu.org/pages/about06.htm
	^ push stack 66 http://www.akaedu.org/pages/about06.htm 1

	-> find url: http://www.akaedu.org/tencent://message/?uin=2252421714&Site=??Ƕ????&Menu=yes
	^ push stack 67 http://www.akaedu.org/tencent://message/?uin=2252421714&Site=??Ƕ????&Menu=yes 1

	-> find url: http://www.akaedu.org/tencent://message/?uin=475739671&Site=??Ƕ????&Menu=yes
	^ push stack 68 http://www.akaedu.org/tencent://message/?uin=475739671&Site=??Ƕ????&Menu=yes 1

	-> find url: http://www.akaedu.org/tencent://message/?uin=575963343&Site=??Ƕ????&Menu=yes
	^ push stack 69 http://www.akaedu.org/tencent://message/?uin=575963343&Site=??Ƕ????&Menu=yes 1

	-> find url: http://www.akaedu.org
	x has been crawled

	-> find url: http://www.akaedu.org
	x has been crawled

	--- 2 page crawling
	@ pop 3  http://www.akaedu.org/pages/about01.htm
	  try open http://www.akaedu.org/pages/about01.htm
	  open and read ok
	^ push crawled 3 http://www.akaedu.org/pages/about01.htm

	--- 3 page crawling
	@ pop 4  http://www.akaedu.org/pages/team01.htm
	  try open http://www.akaedu.org/pages/team01.htm
	  open and read ok
	^ push crawled 4 http://www.akaedu.org/pages/team01.htm

	--- 4 page crawling
	@ pop 5  http://www.akaedu.org/page/zyindex.php
	  try open http://www.akaedu.org/page/zyindex.php
	  open and read ok
	+ add email: hongtao0615@sina.com
	^ push crawled 5 http://www.akaedu.org/page/zyindex.php

	-> find url: http://www.akaedu.org/favicon.ico
	^ push stack 114 http://www.akaedu.org/favicon.ico 2

	-> find url: http://www.akaedu.org
	x has been crawled

	-> find url: http://www.akaedu.org/pages/about04.php
	x has been crawled

	-> find url: http://www.akaedu.org/pages/about01.htm
	x has been crawled

	-> find url: http://www.akaedu.org/pages/team01.htm
	x has been crawled

	-> find url: http://www.akaedu.org/page/zyindex.php
	x has been crawled

	-> find url: http://www.akaedu.org/pages/ask01.htm
	x already in links_stack

	-> find url: http://www.akaedu.org/pages/about04.php
	x has been crawled


