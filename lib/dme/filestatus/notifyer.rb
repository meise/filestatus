require 'socket'

module Dme
  module Filestatus
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
  end
end