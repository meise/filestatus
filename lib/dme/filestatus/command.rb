require 'daemons'

module Dme
  module Filestatus
    class Command

      def run(opts)

        case opts[:command]
          when /start/
            if opts[:daemonize]
              Daemons.daemonize({:app_name => Dme::Filestatus::NAME, :dir_mode => :system})
            end

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