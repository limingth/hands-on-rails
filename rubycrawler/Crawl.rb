require 'open-uri'
require 'thread'
# run it like this :
# ruby Crawl.rb 2 1000 http://www-cs.stanford.edu/People
# regexp
$link_regexp = /href\=\"[^\"]*\"/
$email_regexp_1 = /mailto\:[^\@]*\@[^\"]*[\"]/	#mailto:xx@xxxx"
$email_regexp_2 = /[\>][^\<]*\@[^\>]*[\<]/	#>xx@xx<
$before_at = /[a-zA-Z0-9]+[_?a-zA-Z0-9]+/
$after_at = /[a-zA-Z]+[-?a-zA-Z]*\.+[a-zA-Z]+/
$email_regexp=/#{$before_at}\@#{$after_at}/	#xx@xx.xx

#ARGV 
if ARGV==nil||ARGV.length<3
	puts '-- Command --'
	puts 'ruby Crawl.rb 2 1000 http://www-cs.stanford.edu/People'
	puts 'help: 2->max_depth, 1000->max_pages, http://www-cs.stanford.edu/People->url'
	exit(0)
end
$url=ARGV[2]
$max_depth=ARGV[0].to_i
$max_pages=ARGV[1].to_i
$fname='emails_md'+String($max_depth)+'_mp'+String($max_pages)+'_'+$url.gsub(/[\/\:]/,'_')+'.txt'
$fname_links='links_md'+String($max_depth)+'_mp'+String($max_pages)+'_'+$url.gsub(/[\/\:]/,'_')+'.txt'
$thread_num=10
$debug=true

$links_stack=[]		#fifo #[[depth1,link1],[depth2,link2],[depth3,link3],...]
$links_crawled=[]	#[url1,url2,url3,...] 
$emails=[]		#[email1,email2,email3,...]

class Crawl
	def initialize url,depth
		@url=url
		while @url[-1,1]=='/'
			@url=@url.slice(0,@url.length-1) 
		end
		@depth=depth
		begin
		@html=open(@url).read
		rescue
		@html=''
		end
	end
	def get_links
		@html.scan($link_regexp) do |match| 
			u=Util.format_url(match,@url)
			if !(u==nil)&&!$links_crawled.include?(match)&&$links_stack.rassoc(match)==nil
				$links_stack.push [@depth,u]
			end
		end
	end
	def get_emails
		@html.scan($email_regexp_1) do |match| 
			match=Util.format_email(match)
			if match!=nil&&!$emails.include?(match)
				$emails.push match
				msg= match+', '+@url
				puts msg
				Util.write($fname,msg+"\r\n")
			end
		end
		@html.scan($email_regexp_2) do |match| 
			match=Util.format_email(match)
			if match!=nil&&!$emails.include?(match)
				$emails.push match
				msg= match+', '+@url
				puts msg
				Util.write($fname,msg+"\r\n")
			end
		end
	end
end

class Util
	# format url
	def Util.format_url url,f_url
		# remove 'www-'
		f_url=f_url.gsub(/www\-/, '')
		url=url[6,url.length-7]
		# exclude css & js & '#'(eg http://www-cs.stanford.edu/People/faculty#Regular%20Faculty)...
		if Util.exclude(url)==nil||url.include?('#')
			return nil
		end
		# full path
		if url[0,4]!='http'
			while url.index('/')==0
				url=url.slice(1,url.length-1) 
			end
			url=f_url+'/'+url
		end
		return url
	end
	# format email
	def Util.format_email email
		email=email.delete('>').delete('<').delete('mailto:').delete('"').strip
		if String($email_regexp.match(email))== email
			return email.downcase
		else
			return nil
		end
	end
	# write msg to file
	def Util.write fname,msg
		file=File.new(fname,'a')
		file<<msg
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
end
$count=1
0.upto($max_depth) do |i|
	if $debug
		puts '~~depth->'+String(i)
	end	
	if i==0
		c=Crawl.new($url,i+1)
		c.get_links
		c.get_emails
		$links_crawled.push [i,$url]
	end
	#breadth first 
	while $links_stack.length!=0
		if $debug
			puts '~~count->'+String($count)+',stack->'+String($links_stack.length)+',crawled->'+String($links_crawled.length)+',total->'+String($links_crawled.length+$links_stack.length)
			$count=$count+1
		end		
		#Thread.abort_on_exception = true
		threads = []
		if $links_stack.length/$thread_num>=1
			ts=$thread_num
		else 
			ts=$links_stack.length%$thread_num
		end
		ts.times { |i|
			threads << Thread.new(i) {
			Mutex.new.synchronize {
				if ($links_crawled.length+$links_stack.length)<=$max_pages&&i!=$max_depth
					link=$links_stack.shift		#fifo
					if  link[0]==i+1
						#read links & emails from pages in stack
						c=Crawl.new(link[1],i+2)
						c.get_links
						c.get_emails
						$links_crawled.push link[1]
					else 
						break
					end
				else
					#only read emails from pages in stack
					link=$links_stack.shift
					c=Crawl.new(link[1],i+2)
					c.get_emails
					$links_crawled.push link[1]
				end
			}
			}
		}
		threads.each{|t|t.join}
	end
end

