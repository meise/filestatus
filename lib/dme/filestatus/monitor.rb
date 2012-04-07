require 'fssm'

module Dme
  module Filestatus
    class Monitor

      def initialize
        @monitor   = FSSM::Monitor.new
      end

      def control(files_to_monitor)
        files_to_monitor.each do |directory_and_files|

          directory = directory_and_files.first
          files     = directory_and_files.last.map(&:to_s)

          @monitor.path directory do
            glob files

            update {|base, relative, type| Dme::Filestatus::Notifyer.send_notification(base, relative, "Updated file")}
            delete {|base, relative, type| Dme::Filestatus::Notifyer.send_notification(base, relative, "Deleted file")}
            create {|base, relative, type| Dme::Filestatus::Notifyer.send_notification(base, relative, "Created file")}
          end
        end

        @monitor.run
      end
    end
  end
end