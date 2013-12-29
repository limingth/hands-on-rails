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

$rooturl = "http://www.innocamp.net"	# http:// is necessary for open()
#$rooturl = "http://www.akaedu.us"	# http:// is necessary for open()
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
			dprint "html: " + @html.to_s
			puts "try open " + @url
			@html = open(@url).read
			puts "open and read ok"
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
				dprint "+ save " + match
				puts match
				Util.write($email_file, match)
			end
		end
	end
	
	def get_links
		@html.scan($link_regex) do |match|
			dprint "find link: " + match

			u = Util.format_url(match, @url)
			if u != nil 
				dprint "find u: " + u
				if match != nil && !$links_crawled.include?(match) && $links_stack.rassoc(match) == nil
					u = u.delete("\n")
					$pushcnt = $pushcnt+ 1
					puts "^ push " + $pushcnt.to_s + " " + u + " " + @depth.to_s 
					$links_stack.push [@depth, u]
				end
			end
		end
	end

end


$count = 1
0.upto($max_depth) do |i|
	dprint i

	if i == 0
		c = Crawl.new($rooturl, i+1)
		c.get_emails	
		c.get_links
		$links_crawled.push $rooturl
	end 

	while $links_stack.length != 0
		dprint 'count->'+String($count)
		dprint 'stack->'+String($links_stack.length)
		dprint 'crawled->'+String($links_crawled.length)

		$count = $count + 1

		# get the item at the head of queue
		# That's called breadth-first-search  
		link = $links_stack.shift
		$popcnt = $popcnt + 1
		puts "@ pop " + $popcnt.to_s + " " + link[1] + " " + link[0].to_s 

		if link[0] == i + 1
			c = Crawl.new(link[1], i+2)
			if ($links_crawled.length+$links_stack.length) <= $max_pages
				c.get_links
			end
			c.get_emails
			$links_crawled.push link[1]
		else
			break
		end
	end
	
end

puts $email_file
