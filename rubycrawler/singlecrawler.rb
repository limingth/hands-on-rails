#!/bin/ruby

script_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift script_dir

$url = "http://bbs.66xue.com/thread-308345-2-1.html"
require 'mycrawler.rb'

$max_depth = 10
$max_pages = 100000

def mainloop
	# push the root url to links_stack
	$links_stack.push [0, $url]

	# while stack is not empty
	while $links_stack.length != 0
		dprint 'links stack ->'+String($links_stack.length)
		dprint 'links crawled ->'+String($links_crawled.length)

		# begin to pop links from links_stack
		$popcnt = $popcnt + 1
		dprint "@ pop " + $popcnt.to_s + " " + $dep.to_s + " " + @url.to_s 
		puts "\n--- #{$popcnt} pages crawling...#{$links_stack.length} links left, #{$email_counter} emails found, #{$open_err} url error!"

		# get the item at the head of queue
		# That's called breadth-first-search  
		link = $links_stack.shift
		@dep = link[0]
		@url = link[1]
		$current_url = @url

		# if current link[0] level reach to max_depth, then break
		if @dep == $max_depth + 1 
			break
		end

		# add 1 level from current one to expand
		puts "  try open " + @url
		c = Crawl.new(@url, @dep+1)
		puts "  open and read ok"

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

