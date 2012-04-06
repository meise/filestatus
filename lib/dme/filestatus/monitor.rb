require 'fssm'

module Dme
  module Filestatus
    FSSM.monitor do
      # files in /etc/
      path '/etc/' do
        glob ['passwd', 'shadow', 'sudoers', 'group', 'rc.local']

        update {|base, relative, type| send_notification(base, relative, "Updated file", bot, receivers)}
        delete {|base, relative, type| send_notification(base, relative, "Deleted file", bot, receivers)}
        create {|base, relative, type| send_notification(base, relative, "Created file", bot, receivers)}
      end

      # files in /root/.ssh/
      path '/root/.ssh/' do
        glob ['authorized_keys']

        update {|base, relative, type| send_notification(base, relative, "Updated file", bot, receivers)}
        delete {|base, relative, type| send_notification(base, relative, "Deleted file", bot, receivers)}
        create {|base, relative, type| send_notification(base, relative, "Created file", bot, receivers)}
      end
    end
  end
end