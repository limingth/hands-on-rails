#!/bin/ruby

# https://github.com/adennis4/email-scanner
# http://bubble.iteye.com/blog/545160

require 'open-uri'
require 'thread'

# comment this line for no debug info
#$debug = true

# count for email number
$count = 0

def dprint msg
	if $debug == true 
		puts "<debug> " + msg.to_s
	end
end

dprint "My email crawler v1.0"

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# change your url here, that's all, leave the rest to us
#$url = "http://www.itpub.net/thread-1206888-1-1.html"
$url = "http://www.itpub.net/list.html"
#$url = "http://ruby-china.org/topics"
#$url = "https://github.com/limingth"
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
$current_url = $url

def regular_url

# these value are just for test, see real value of $url at code beginning
# $url = "http://www.itpub.net/test/subdir/thread-1206888-1-1.html"
# $url = "http://www.itpub.net/"
# $url = "http://www.itpub.net"

# $url could be any url you want to paste here like http://www.abc.com/test/dir/index.html
# $url_root must be a url like http://www.abc.com
# $url_dir must be a url like http://www.abc.com/test/dir/
# $url_file must be the last file name like index.html

	puts $url

	$url_root = $url.match(/https?:\/\/[^\/]*/).to_s
	puts "url root is " + $url_root

	$url_dir = $url.match(/https?:\/\/[^\/].*\//).to_s
	if $url_dir == ''
		$url_dir = $url
	end
	puts "url dir is " + $url_dir

	$url_file = $url
	$url_file = $url_file.gsub(/https?:\/\/[^\/].*\//, '')
	if $url_file == $url
		$url_file = ''
	end
	puts "url file is " + $url_file

	puts $url
	#exit
end

#$url = "http://www.itpub.net"
#$url = "http://www.akaedu.us"	# http:// is necessary for open()
#$url = "http://www.innocamp.net"	# http:// is necessary for open()
#$url = "http://www.akaedu.org"	# http:// is necessary for open()
#$url = "http://www.mitbbs.com"	# http:// is necessary for open()
#$url = "http://www.wenxuecity.com"	# http:// is necessary for open()
#$url = "http://bbs.wenxuecity.com"
#$url = "http://sfbay.craigslist.org"
#$url = "http://www.pku.edu.cn"
#$url = "http://www.sofang.com"
#$url = "http://bbs.wenxuecity.com"


regular_url()

$url_name = $url_root.gsub(/https?:\/\//, '')
puts $url_name
t = Time.now
#$time = t.strftime "%Y-%m-%d_%H:%M:%S"  => "2012-11-10 17:16:12"
$time = t.utc.to_s

$email_file = $time + "_" + $url_name + "_email.dat"
$links_file = $time + "_" + $url_name + "_links.dat"	# save all links crawled
$tasks_file = $time + "_" + $url_name + "_tasks.dat"	# save all links to be crawled

puts $email_file
puts $links_file

$max_depth = 10 
$max_pages = 100000

$thread_num = 10

$email_regex = /(?:"([^@]*)"\s.\b(?:mailto:)*)*([\w._%+-]+@[a-zA-Z0-9.-]+\.[a-z]{2,4})\b./i
$emails = []

$link_regex = /href\=\"[^\"]*\"/
$links_stack = []
$links_crawled = []

$pushcnt = 0
$popcnt= 0

$crawled_pushcnt = 0

$open_err = 0
$links_inpage = 0

class Util
	def Util.write fname, msg
		file = File.new(fname, 'a')
		file << msg + " # from " + $current_url + "\r\n"
		file.close()
	end

	def Util.savestack
		file = File.new($links_file, 'a')
		while $links_crawled.length != 0
			@url = $links_crawled.shift
			file << @url + "\r\n"
		end
		file.close()

		file = File.new($tasks_file, 'a')
		while $links_stack.length != 0
			link = $links_stack.shift
			@url = link[1]

			file << @url + "\r\n"
		end
		file.close()
	end

        # exclude css & js...
        def Util.exclude str
                ex=['css','js','pdf','jpg','png','zip','gif']
                ex.each do |e|
                        index=e.length+1
                        if str.length>index && str[-index,index]=='.'+e
                                return nil
                        end
                end
                return str
        end

	def Util.format_url url, f_url
		dprint url
		if url.include?('#')
			return nil
		end

		if url[0, 5] == 'href='
			url = url[6, url.length-7]
		else
			return nil
		end
		dprint url

		if Util.exclude(url) == nil
			dprint "css, js, pdf, jpg -> no push"
			return nil
		end

		if url[0, 4] == 'http'
			#return url		
			return nil	# we just search in this site
		end

		if url[0, 6] == 'mailto'
			return nil
		end

		if url[0, 10] == 'javascript'
			return nil
		end

		if url[0, 1] == '/'
			url = $url_root + url
		else
			url = $url_dir + url
		end
		dprint url

		url = url.chomp("\n")
		url = url.chomp("/")
		return url
	end
end

class Crawl
	def initialize url, depth
		@url = url
		@depth = depth
		@html = ''

		begin
			dprint "open url: " + @url
			@html = open(@url).read
			dprint "html: " + @html.to_s
		end
			dprint "html: " + @html.to_s
			if @html.to_s == ''
				dprint "ERROR in open " + @url
			else
				dprint "OK in open " + @url
			end
			rescue
			puts "  opened error #{$open_err} times"
			$open_err += 1
			@html = ''
	end

	def get_emails
		@html.scan($email_regex) do |matchs|
			match = matchs[1]
			dprint "find email: " + match

			if match != nil && !$emails.include?(match)
				$emails.push match
				$count += 1
				puts "+ add email #{$count}: " + match
				Util.write($email_file, match)
			end
		end
	end
	
	def get_links
		$links_inpage = 0
		if ($links_crawled.length+$links_stack.length) > $max_pages
			return
		end

		@html.scan($link_regex) do |match|
			dprint "find link: " + match

			u = Util.format_url(match, @url)
			dprint "format url: " + u.to_s

			if u != nil 
				#puts "\n-> find url: " + u
				dprint $links_crawled

				if $links_stack.rassoc(u)
					#puts "x already in links_stack"
					next
				end

				if $links_crawled.include?(u)
					#puts "x has been crawled"
					next
				end

				$pushcnt = $pushcnt+ 1
				$links_inpage += 1
				#puts "^ push stack " + $pushcnt.to_s + " " + u + " " + @depth.to_s 
				$links_stack.push [@depth, u]
			end
		end
	end

end


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
rescue Interrupt => e
  puts "Note: all links crawled and to be crawled are saved"
  Util.savestack
end

