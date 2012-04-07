require 'socket'

module Dme
  module Filestatus
    module Notifyer

      def self.send_notification(directory, file, status)
        Dme::Filestatus::Config.informants.each do |informant|
          informant.send_message(directory, file, status)
        end
      end

    end
  end
end