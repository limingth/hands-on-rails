#!/bin/ruby

# https://github.com/adennis4/email-scanner
# http://bubble.iteye.com/blog/545160

require 'open-uri'
require 'thread'

def dprint msg
	if $debug == true
		puts msg	
	end
end

dprint "My email crawler v1.0"

$rooturl = "http://www.akaedu.us"	# http:// is necessary for open()
#$rooturl = "http://www.innocamp.net"	# http:// is necessary for open()
#$rooturl = "http://www.akaedu.org"	# http:// is necessary for open()
#$rooturl = "http://www.mitbbs.com"	# http:// is necessary for open()
#$rooturl = "http://www.wenxuecity.com"	# http:// is necessary for open()
#$rooturl = "http://bbs.wenxuecity.com"
#$rooturl = "http://sfbay.craigslist.org"
#$rooturl = "http://www.pku.edu.cn"
#$rooturl = "http://www.sofang.com"
#$rooturl = "http://bbs.wenxuecity.com"

$url_name = $rooturl.gsub(/http:\/\//, '')
puts $url_name
$email_file = Time.now.to_s + "_" + $url_name + ".dat"
puts $email_file
$max_depth = 10 
$max_pages = 100000

$thread_num = 10
#$debug = true

$email_regex = /(?:"([^@]*)"\s.\b(?:mailto:)*)*([\w._%+-]+@[a-zA-Z.-]+\.[a-z]{2,4})\b./i
$emails = []

$link_regex = /href\=\"[^\"]*\"/
$links_stack = []
$links_crawled = []

$pushcnt = 0
$popcnt= 0

$crawled_pushcnt = 0

class Util
	def Util.write fname, msg
		file = File.new(fname, 'a')
		file << msg + "\r\n"
		file.close()
	end

        # exclude css & js...
        def Util.exclude str
                ex=['css','js','pdf','jpg']
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
			url = $rooturl + url
		else
			url = $rooturl + '/' + url
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
			puts "opened error "
			@html = ''
	end

	def get_emails
		@html.scan($email_regex) do |matchs|
			match = matchs[1]
			dprint "find email: " + match

			if match != nil && !$emails.include?(match)
				$emails.push match
				puts "+ add email: " + match
				Util.write($email_file, match)
			end
		end
	end
	
	def get_links
		if ($links_crawled.length+$links_stack.length) > $max_pages
			return
		end

		@html.scan($link_regex) do |match|
			dprint "find link: " + match

			u = Util.format_url(match, @url)
			dprint "format url: " + u.to_s

			if u != nil 
				puts "\n-> find url: " + u
				dprint $links_crawled

				if $links_stack.rassoc(u)
					puts "x already in links_stack"
					next
				end

				if $links_crawled.include?(u)
					puts "x has been crawled"
					next
				end

				$pushcnt = $pushcnt+ 1
				puts "^ push stack " + $pushcnt.to_s + " " + u + " " + @depth.to_s 
				$links_stack.push [@depth, u]
			end
		end
	end

end



# push the root url to links_stack
$links_stack.push [0, $rooturl]

# while stack is not empty
while $links_stack.length != 0
	dprint 'links stack ->'+String($links_stack.length)
	dprint 'links crawled ->'+String($links_crawled.length)

	# get the item at the head of queue
	# That's called breadth-first-search  
	puts "\n--- #{$popcnt} page crawling"
	link = $links_stack.shift
	@dep = link[0]
	@url = link[1]

	$popcnt = $popcnt + 1
	puts "@ pop " + $popcnt.to_s + " " + $dep.to_s + " " + @url.to_s 


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
	puts "^ push crawled " + $crawled_pushcnt.to_s + " " + @url
	dprint $links_crawled


	# then we try to get links from this @url
	c.get_links
end

puts $email_file
