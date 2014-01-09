#!/bin/ruby

# https://github.com/adennis4/email-scanner
# http://bubble.iteye.com/blog/545160

require 'open-uri'
require 'thread'

# comment this line for no debug info
#$debug = true

# counter for email number
$email_counter = 0

def dprint msg
	if $debug == true 
		puts "<debug> " + msg.to_s
	end
end

dprint "My email crawler v1.0"

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# change your url here, that's all, leave the rest to us
#$url = "http://www.itpub.net/thread-1206888-1-1.html"
#$url = "http://www.itpub.net/list.html"
#$url = "http://bbs.66xue.com/thread-308345-2-1.html"
#$url = "http://ruby-china.org/topics"
#$url = "https://github.com/limingth"
if $url == nil
	$url = "http://innocamp.net"
end
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
$current_url = $url

if ARGV[0].to_s != ''
  $url = ARGV[0]
end
puts "Get url to crawl: <" + $url.to_s + ">"
sleep 1

def regular_url
	# these value are just for test, see real value of $url at code beginning
	# $url = "http://www.itpub.net/test/subdir/thread-1206888-1-1.html"
	# $url = "http://www.itpub.net/"
	# $url = "http://www.itpub.net"

	# $url could be any url you want to paste here like http://www.abc.com/test/dir/index.html
	# $url_root must be a url like http://www.abc.com
	# $url_dir must be a url like http://www.abc.com/test/dir/
	# $url_file must be the last file name like index.html
	dprint $url

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

	dprint $url
	#exit
end

regular_url()

$url_name = $url_root.gsub(/https?:\/\//, '')
dprint $url_name

t = Time.now
$time = t.utc.to_s
$time = t.localtime
$time = t.strftime "%Y-%m-%d_%H.%M.%S"  	# => "2012-11-10 17:16:12"
puts $time

$url_time_file = $url_name.to_s + "_" + $time.to_s + ".dat"
$url_time_file = $url_time_file.to_s
puts $url_time_file

$email_file = "emails_" + $url_time_file	# save all emails crawled
$links_file = "links_" + $url_time_file		# save all links crawled
$tasks_file = "tasks_" + $url_time_file		# save all links to be crawled
$error_file = "errors_" + $url_time_file		# save all error links 

puts $email_file
puts $links_file
puts $tasks_file
puts $error_file

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

	def Util.write fname, msg, myurl
		file = File.new(fname, 'a')
		file << msg + " # from " + myurl + "\r\n"
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

		# first cut off \n if there is 
		url = url.chomp("\n")
		#dprint url

		if url.include?('#')
			return nil
		end

		if url[0, 5] != 'href='
			return nil
		end

		# get the url_string from href=url_string
		url = url[6, url.length-7]
		dprint "real url found: " + url

		# get rid of all invalid url
		# http://xxx.com/a.pdf
		if Util.exclude(url) == nil
			dprint "css, js, pdf, jpg -> no push"
			return nil
		end

		# mailto:abc@xxx.com
		if url[0, 6] == 'mailto'
			return nil
		end

		# javascript(0)
		if url[0, 10] == 'javascript'
			return nil
		end

		# http://xxx.com as http://xxx.com/new/dir/newlink
		if url[0, $url_root.length] == $url_root
			return url	# this url is in this same site	
		end

		#  http://cache.baiducontent.com/
		if url[0, 30] == "http://cache.baiducontent.com/"
			return url
		end

		# out-site url, then just drop it
		if url[0, 4] == 'http'
			return nil
		end

		# in-site url with '/', then add $url_root as prefix
		if url[0, 1] == '/'
			url = $url_root + url
			return url
		end

		# in-site url without '/', then add $url_dir as prefix
		url = $url_dir + url
		dprint url
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
			file = File.new($error_file, 'a')
			file << "open error: " + @url + "\r\n"
			file.close()
			@html = ''
	end

	def get_emails
		@html.scan($email_regex) do |matchs|
			match = matchs[1]
			dprint "find email: " + match

			if match != nil && !$emails.include?(match)
				$emails.push match
				$email_counter += 1
				puts "+ add email #{$email_counter}: " + match
				Util.write($email_file, match, @url)
			end
		end
	end
	
	def get_links

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

def test
	@dep = 1
	@url = $url

# add 1 level from current one to expand
	puts "  try open " + @url.to_s
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
	$links_inpage = 0
	c.get_links
	puts "  #{$links_inpage} links pushed to stack\n"

	puts "see all emails in " + $email_file
	puts "see all links in " + $links_file
	Util.savestack

	while $links_stack.length != 0
		$popcnt = $popcnt + 1
		puts "\n--- #{$popcnt} pages crawling...#{$links_stack.length} links left, #{$email_count} emails found, #{$open_err} url error!"

		link = $links_stack.shift
		@dep = link[0]
		@url = link[1]
	end

end

test
puts "#{$url} crawled at #{$time} with #{$email_counter} emails found!"
puts "Game Over"
