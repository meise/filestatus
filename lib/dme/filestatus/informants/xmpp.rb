require 'xmpp4r/client'

module Dme
  module Filestatus
    class Xmpp

      attr_accessor :client, :recipients

      def initialize(account, password, recipients)
        Jabber::debug  = true
        @client        = Jabber::Client.new(account)

        @recipients    = recipients
        @password      = password
      end

      def send_notification(message)

        @client.connect
        @client.auth(@password)

        @receivers.each do |receiver|
          client.send Jabber::Message.new(receiver, message)
        end
      end
    end
  end
end