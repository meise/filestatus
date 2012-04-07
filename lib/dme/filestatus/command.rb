require 'daemons'

module Dme
  module Filestatus
    class Command

      # Converts the object into textual markup given a specific format.
      #
      # @param [Hash]
      def run(opts)
        puts "#{Gem.datadir(Dme::Filestatus::NAME) + '/config.yml.example'}"

        case opts[:command]
          when /start/
            Dme::Filestatus::Monitor.new.control(Dme::Filestatus::Config.directories)
          when /stop/
            # stop
          when /status/
            # status
          when /restart/
            # restart
        end
      end

    end
  end
end