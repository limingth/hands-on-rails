

# How to use rubymailer

## modify setenv.sh

    $ vi setenv.sh
    modify Line 1 and Line 2 to your qq account and password
    
## change the mail title and content if need

    you can edit title.txt and content.txt to your info
    
## execute `. setenv.sh` to set env variable

    $ . setenv.sh
    
## change test@gmail.com to your gmail and test send a single mail

    $ echo test@gmail.com | ruby mymailer.rb
    
## make a emaillists and send the bulk email with a cat command

    $ cat emails.txt | ruby mymailer.rb
    
