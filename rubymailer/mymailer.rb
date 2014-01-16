require 'net/smtp'

# Don't forget to set your env before your run 'ruby mymailer.rb'
# $ export SMTP_U='yourqq@qq.com'
# $ export SMTP_P='yourpassword'

server = 'smtp.exmail.qq.com'
port = 465

smtp_user = ENV['SMTP_U']
smtp_pass = ENV['SMTP_P']
mail_title = ENV['MAIL_TITLE']
mail_content = ENV['MAIL_CONTENT']

puts smtp_user
puts smtp_pass
puts mail_title
puts mail_content

from = smtp_user
to = 'limingth@gmail.com'

message_body = <<END_OF_EMAIL
From: <#{smtp_user}>
To: Li Ming <limingth@gmail.com>
MIME-Version: 1.0
Content-type: text/html
Subject: #{mail_title} 

#{mail_content}
END_OF_EMAIL

puts message_body

smtp = Net::SMTP.new(server, port)
smtp.enable_ssl
smtp.start(server, smtp_user, smtp_pass, :plain)
smtp.send_message(message_body, from, to)

