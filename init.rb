#!/usr/bin/env ruby
### BEGIN INIT INFO
# Provides:          filestatus
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Init script for file monitoring script.
### END INIT INFO

require 'aef/init'

class Filestatus < Aef::Init
  PATH = Pathname('/usr/local/sbin/')
  DAEMON = PATH + 'filestatus'

  # Defines the seconds to wait between stop and start in the predefined restart
  # command
  stop_start_delay 1

  # An implementation of the start method for the mumble daemon
  def start
    system("ruby #{DAEMON} &")
  end

  # An implementation of the stop method for the mumble daemon
  def stop
    system("pkill -f #{DAEMON}")
  end
end

if __FILE__ == $PROGRAM_NAME
  Filestatus.parse
end
