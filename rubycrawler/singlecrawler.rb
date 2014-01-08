#!/bin/ruby

script_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift script_dir
require 'mycrawler.rb'

def mainloop
	# push the root url to links_stack
	$links_stack.push [0, $url]

	# while stack is not empty
	while $links_stack.length != 0
		dprint 'links stack ->'+String($links_stack.length)
		dprint 'links crawled ->'+String($links_crawled.length)

		# get the item at the head of queue
		# That's called breadth-first-search  
		puts "\n--- #{$popcnt} pages crawling...#{$links_stack.length} links left, #{$count} emails found, #{$open_err} url error!"
		link = $links_stack.shift
		@dep = link[0]
		@url = link[1]
		$current_url = @url

		$popcnt = $popcnt + 1
		#puts "@ pop " + $popcnt.to_s + " " + $dep.to_s + " " + @url.to_s 

		# if current link[0] level reach to max depth, then break
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
		c.get_links

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

