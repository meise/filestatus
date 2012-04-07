require 'xmpp4r/client'

module Dme
  module Filestatus
    class Xmpp

      attr_accessor :client, :recipients

      def initialize(account, password, recipients)
        Jabber::debug  = false
        @client        = Jabber::Client.new(account)

        @recipients    = recipients
        @password      = password
      end

      def send_message(directory, file, status)
        @message =<<-MESSAGE

== Security warning ==

HOST: #{Socket.gethostname}
DATE: #{Time.now}
FILE: #{status} #{directory}/#{file}

# last logins
#{%x{last -n10 -a}}
# netstat
#{%x{netstat -utan}}
        MESSAGE

        @client.connect
        @client.auth(@password)

        @recipients.each do |receiver|
          client.send Jabber::Message.new(receiver, @message)
        end
      end
    end
  end
end