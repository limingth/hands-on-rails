#!/bin/ruby

require 'net/smtp'

# Don't forget to set your env before your run 'ruby mymailer.rb'

# get all configuration from env
$smtp_serv = ENV['SMTP_SERV']
$smtp_port = ENV['SMTP_PORT']
$user_name = ENV['USER_NAME']
$smtp_user = ENV['SMTP_USER']
$smtp_pass = ENV['SMTP_PASS']
$mail_title = ENV['MAIL_T']
$mail_content = ENV['MAIL_C']

# puts $smtp_serv
# puts $smtp_port
# puts $smtp_user
# puts $smtp_pass
puts $mail_title
# puts $mail_content

$from = $smtp_user

$message_from = "From: #{$user_name} <#{$smtp_user}>\n"
# puts $message_from

# $message_mime = "MIME-Version: 1.0\nContent-type: text/html\n"
$message_mime = ""
$message_subject = "Subject: #{$mail_title}\n"
$message_content = "#{$mail_content}"

def mysendmail(to)
	$message_to = "To: <#{to}>\n"
	# puts $message_to

	body = $message_from + $message_to + $message_mime + $message_subject + $message_content
	# puts message_body

	smtp = Net::SMTP.new($smtp_serv, 465)
	smtp.enable_ssl
	smtp.start($smtp_serv, $smtp_user, $smtp_pass, :plain)
	smtp.send_message(body, $from, to)
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
	sleep 11
    rescue
	print "error\n"
    end
end
