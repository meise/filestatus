module Dme
  module Filestatus
    module Log
      @@logger = nil

      def self.info(message)
        self.log.info(message)
      end

      def self.warn(message)
        self.log.warn(message)
      end

      def self.debug(message)
        self.log.debug(message)
      end

      protected

      def self.log
        unless @@logger
          @@logger          = Logger.new(STDOUT)
          @@logger.level    = Logger::INFO
          @@logger.progname = Dme::Filestatus::NAME
        end

        @@logger
      end
    end
  end
end