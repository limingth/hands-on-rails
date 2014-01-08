#!/bin/ruby

require 'open-uri'
require 'thread'

#$url = "http://www.baidu.com"
#$url = "http://qun.qzone.qq.com/group#\!/69441899/member"
$url = "http://akaedu.us"

$email_regex = /(?:"([^@]*)"\s.\b(?:mailto:)*)*([\w._%+-]+@[a-zA-Z0-9.-]+\.[a-z]{2,4})\b./i

puts "ARGV[0] is <" + ARGV[0].to_s + ">"

if ARGV[0].to_s != ""
  $url = ARGV[0]
end

puts $url

$html = ''

$html = open($url).read

if $html.to_s == ''
	puts "open url error"
else
	puts "url ok!"
	puts "html: " + $html.to_s
end

$html.scan($email_regex) do |matchs|
	match = matchs[1]
	#puts "find email: " + match
	puts match
end
