#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems'

require 'fssm'
require 'xmpp4r/client'
require 'socket'

# Jabber::debug = true

bot = Jabber::Client.new('3st@jabber.ccc.de/bot')
bot.connect
bot.auth('stroke+town4Rex')

receivers = %w{meise@jabber.ccc.de}

def send_notification(directory, file, status, client, receivers) 
  git_diff = ''
  if Pathname.new("#{directory}/.git").exist?
    git_diff = %x{git diff -u #{directory}/#{file}}
  end

  message =<<MESSAGE

== Security warning ==

HOST: #{Socket.gethostname}
DATE: #{Time.now}
FILE: #{status} #{directory}/#{file}

#{git_diff}
# last logins
#{%x{last -n10 -a}}
# netstat
#{%x{netstat -utan}}
MESSAGE
  
  receivers.each do |receiver| 
    client.send Jabber::Message.new(receiver, message)
  end
end

FSSM.monitor do
  # files in /etc/
  path '/etc/' do
    glob ['passwd', 'shadow', 'sudoers', 'group']

    update {|base, relative, type| send_notification(base, relative, "Updated file", bot, receivers)}
    delete {|base, relative, type| send_notification(base, relative, "Deleted file", bot, receivers)}
    create {|base, relative, type| send_notification(base, relative, "Created file", bot, receivers)}
  end

  # files in /root/.ssh/
  path '/root/.ssh/' do
    glob ['authorized_keys'] 

    update {|base, relative, type| send_notification(base, relative, "Updated file", bot, receivers)}
    delete {|base, relative, type| send_notification(base, relative, "Deleted file", bot, receivers)}
    create {|base, relative, type| send_notification(base, relative, "Created file", bot, receivers)}
  end
end
