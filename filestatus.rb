#!/usr/bin/env ruby
# encoding: utf-8

=begin
Copyright Daniel Meißner <dm@3st.be>, 2012

This file is part of filestatus to send xmpp notifications if
critical system files are modified.

This script is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This Script is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with filestatus. If not, see <http://www.gnu.org/licenses/>.
=end

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
  ip_addresses = []
  Socket.ip_address_list.each{|a| ip_addresses << a.ip_address}

  git_diff = ''
  if Pathname.new("#{directory}/.git").exist?
    git_diff = %x{git diff -u #{directory}/#{file}}
  end

  message =<<MESSAGE

== Security warning ==

HOST: #{Socket.gethostname}
ADDR: #{ip_addresses}
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
    glob ['passwd', 'shadow', 'sudoers', 'group', 'rc.local']

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
