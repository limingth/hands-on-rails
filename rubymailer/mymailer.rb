#!/bin/ruby
require 'net/smtp'

# Don't forget to set your env before your run 'ruby mymailer.rb'
# $ export SMTP_U='yourqq@qq.com'
# $ export SMTP_P='yourpassword'
# $ export MAIL_T='Mail Title'
# $ export MAIL_C='Mail Content'

server = 'smtp.exmail.qq.com'
port = 465

smtp_user = ENV['SMTP_U']
smtp_pass = ENV['SMTP_P']
mail_title = ENV['MAIL_T']
mail_content = ENV['MAIL_C']

#puts smtp_user
#puts smtp_pass
puts mail_title
#puts mail_content

$from = smtp_user

#puts message_body

$smtp = Net::SMTP.new(server, port)
$smtp.enable_ssl
$smtp.start(server, smtp_user, smtp_pass, :plain)

$message_from = "From: 硅谷训练营 <#{smtp_user}>\n"
#$message_mime = "MIME-Version: 1.0\nContent-type: text/html\n"
$message_mime = ""
$message_subject = "Subject: #{mail_title}\n"
$message_content = "#{mail_content}"

def mysendmail(to)
	$message_to = "To: <#{to}>\n"
	message_body = $message_from + $message_to + $message_mime + $message_subject + $message_content
	#puts $message_from
	#puts $message_to
	$smtp.send_message(message_body, $from, to)
end

count = 0

while true
	to = gets
	if to == nil
		break
	end

	to.chomp!
	if to[0] == '#'
		puts "x omiting mail to #{to}"
		next
	end
	count += 1
	print "+ sending #{count} mail to #{to} ..."

    begin
	mysendmail to
	print "ok\n"
    rescue
	print "error\n"
    end
	sleep 20
end
