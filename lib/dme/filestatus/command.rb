require 'daemons'

module Dme
  module Filestatus
    module Command

      def self.run(opts)

        case opts[:command]
          when /start/

            if opts[:daemonize]
              Daemons.daemonize({ :app_name => Dme::Filestatus::NAME, :ontop => false, :backtrace => true,
                                  :dir_mode => :normal, :dir => Dme::Filestatus::Config.config_file.dirname,
                                  :log_dir  => Dme::Filestatus::Config.log_file.dirname })
            end

            Dme::Filestatus::Monitor.new.control(Dme::Filestatus::Config.directories)

          when /stop/

            if File.exist?( Dme::Filestatus::Config.pid_file )
              Process.kill( 'SIGINT', File.read( Dme::Filestatus::Config.pid_file ).chomp.to_i )
            end

          when /status/

            if File.exist?( Dme::Filestatus::Config.pid_file )
              pid = File.read( Dme::Filestatus::Config.pid_file )

              puts "#{Dme::Filestatus::NAME.capitalize} is running. \nPid: #{pid.chomp}".color(:yellow)
            else
              puts 'Application is not running.'
            end

          when /restart/
            #
            # restart
            #
        end
      end
    end
  end
end