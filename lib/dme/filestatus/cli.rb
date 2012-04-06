require 'optparse'
require 'rainbow'

module Dme
  module Filestatus
    class Cli

      attr_accessor :options

      def initialize(argv)
        @options   = {}
        @argv = argv

        @parser = OptionParser.new(@argv)
      end

      protected

      def parse
        @parser.parse! do |opts|
          opts.banner = "Usage: filestatus [options]"

          opts.on("-v", "Run verbosely") do |version|
            @options[:version] = version
          end

          @options
        end
      end
    end
  end
end