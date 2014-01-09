#!/bin/ruby

require 'open-uri'

#$url = "http://www.baidu.com"
#$url = "http://qun.qzone.qq.com/group#\!/69441899/member"
$url = "http://akaedu.us"

$email_regex = /(?:"([^@]*)"\s.\b(?:mailto:)*)*([\w._%+-]+@[a-zA-Z0-9.-]+\.[a-z]{2,4})\b./i

puts "ARGV[0] is <" + ARGV[0].to_s + ">"

if ARGV[0].to_s != ""
  $url = ARGV[0]
end

puts $url

t = Time.now
$time = t.utc.to_s
$time = t.localtime
$time = t.strftime "%Y-%m-%d_%H:%M:%S"  # => "2012-11-10 17:16:12"
puts $time

$html = ''

$html = open($url).read

if $html.to_s == ''
	puts "open url error"
else
	puts "url ok!"
	puts "html: " + $html.to_s
end

#puts $html.encoding.name
#$html.to_s.encode("ASCII-8BIT")
#$html.to_s.encode("utf-8")
#$html.to_s.force_encoding("ISO-8859-1").encode("utf-8", replace: nil)
#$html.to_s.force_encoding("utf-8").encode("utf-8", replace: nil)
#puts $html.encoding.name

$email_counter = 0
begin 
	$html.scan($email_regex) do |matchs|
		match = matchs[1]
		$email_counter += 1
		puts "+ #{$email_counter} " + match
	end
	puts "scan finished"
	rescue
	puts "scan error"
end

puts "#{$url} crawled at #{$time} with #{$email_counter} emails found!"
