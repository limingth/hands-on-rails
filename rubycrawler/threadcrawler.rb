#!/bin/ruby

script_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift script_dir

$url = "http://www.baidu.com/s?ie=utf-8&bs=%E5%87%BA%E5%9B%BD+%E8%B5%84%E6%96%99+%E7%95%99%E4%B8%8B%E9%82%AE%E7%AE%B1+tieba&f=8&rsv_bp=1&rsv_spt=3&wd=%E5%87%BA%E5%9B%BD+%E8%B5%84%E6%96%99+%E7%95%99%E4%B8%8B%E9%82%AE%E7%AE%B1+tieba"

require 'mycrawler.rb'

$max_depth = 10
$max_pages = 100000

$thread_num = 10

def mainloop
	# push the root url to links_stack
	$links_stack.push [0, $url]

	# while stack is not empty
	while $links_stack.length != 0
		dprint 'links stack ->'+String($links_stack.length)
		dprint 'links crawled ->'+String($links_crawled.length)

		# empty threads array
		threads = []
		if $links_stack.length / $thread_num >= 1
			ts = $thread_num
		else
			ts = $links_stack.length % $thread_num
		end

	ts.times { |i|
		threads << Thread.new(i) {
		Mutex.new.synchronize {		

			# get the item at the head of queue
			# That's called breadth-first-search  
			#puts "@ pop " + $popcnt.to_s + " " + $dep.to_s + " " + @url.to_s 
			$popcnt = $popcnt + 1
			puts "\n--- #{$popcnt} pages crawling...#{$links_stack.length} links left, #{$email_counter} emails found, #{$open_err} url error!"

			# get the item at the head of queue
			link = $links_stack.shift
			@dep = link[0]
			@url = link[1]
			$current_url = @url

			# if current link[0] level reach to max depth, then break
			if @dep == $max_depth + 1 
				break
			end

			# add 1 level from current one to expand
			puts "  try open " + @url
			c = Crawl.new(@url, @dep+1)
			puts "  open and read ok"

		begin
			# first we search emails and push this @url to $links_crawled
			c.get_emails	

			# add to links crawled stack
			$crawled_pushcnt += 1
			$links_crawled.push @url
			#puts "^ push crawled " + $crawled_pushcnt.to_s + " " + @url
			dprint $links_crawled

			# then we try to get links from this @url
			# if current pages reach to max_pages, then don't get links any more
			$links_inpage = 0
			if ($links_crawled.length+$links_stack.length) < $max_pages
				c.get_links
			end
			puts "  #{$links_inpage} links pushed to stack\n"
		rescue
			puts "there is a scan error in #{@url}"
		end

			# save the current @url to links.dat
			file = File.new($links_file, 'a')
			file << @url + "\r\n"
			file.close()

		}
		}
	}
	threads.each { |t| t.join }

	end

	puts "see all emails in " + $email_file
	puts "see all links in " + $links_file

end

begin
  puts "Press ctrl-C when you get bored"
  mainloop
  Util.savestack
rescue Interrupt => e
  puts "Note: all links crawled and to be crawled are saved"
  Util.savestack
end

