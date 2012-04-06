require 'xmpp4r/client'

module Dme
  module Filestatus
    class Xmpp

      attr_accessor :client

      def initialize
        Jabber::debug = true
        client        = Jabber::Client.new('3st@jabber.ccc.de/bot')

        client.connect
        client.auth
      end

      def send_notification(message)
        receivers.each do |receiver|
          client.send Jabber::Message.new(receiver, message)
        end
      end

      protected

      def connect
        client.connect
      end

      def auth
        client.auth('password')
      end
    end
  end
end