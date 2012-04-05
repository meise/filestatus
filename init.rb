#!/usr/bin/env ruby
### BEGIN INIT INFO
# Provides:          filestatus
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Required-Start:    rsyslog
# Required-Stop:     rsyslog
# Short-Description: Init script for file monitoring script.
### END INIT INFO

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
