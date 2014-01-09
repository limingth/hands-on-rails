DEP=0
NUM=10

all:
	./mycrawler.rb

test:
	ruby Crawl.rb 0 10 http://www.akaedu.us/

clean:
	rm *.dat

list:
	cat emails*.dat | awk '{ print $$1 }'
