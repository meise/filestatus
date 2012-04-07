require 'optparse'

module Dme
  module Filestatus
    module Optparser

      @@commands = %w[start stop restart status init]

      def self.parse(args)
        options = {}

        parser = OptionParser.new do |opts|
          opts.banner = "Usage: filestatus [options] #{@@commands.join('|')}"

          opts.separator ""
          opts.separator "Daemon options:"

          opts.on('-d', '--daemonize', 'Run daemonized in the background') do |daemonize|
            options[:daemonize] = daemonize
          end

          options[:log] = ENV['HOME'] + '/.filestatus/filestatus.log'
          opts.on('-l', '--log FILE', 'File to redirect output (default: ~/.filestatus/filestatus.log)') do |log|
            options[:log] = log
          end

          options[:pid] = ENV['HOME'] + '/.filestatus/filestatus.pid'
          opts.on('-P', '--pid FILE', 'File to store PID (default: ~/.filestatus/pid/filestatus.pid)') do |pid|
            options[:pid] = pid
          end

          opts.separator ""
          opts.separator "Common options:"

          opts.on('-h', '--help', 'Show this message') do |help|
            options[:help] = help
          end

          opts.on('-v', '--version', 'Show version') do |version|
            options[:version] = version
          end
        end

        begin
          parser.parse!(args)
        rescue
          puts parser
          exit(1)
        end

        if options[:version]
          license = File.read(Gem.loaded_specs[Dme::Filestatus::NAME].full_gem_path + '/LICENSE.md')

          puts <<-VERSION
#{Dme::Filestatus::NAME} v#{Dme::Filestatus::VERSION}

#{license}
          VERSION

          exit(0)
        end

        if options[:help]
          puts parser
          exit
        end

        command = args.shift

        unless @@commands.include?(command)
          puts parser
          exit(1)
        end

        options.tap do |opts|
          opts[:args]    = args
          opts[:command] = command
          opts[:config]  = File.expand_path("#{ENV['HOME'] + '/.filestatus/config.yml'}")
          opts[:pid]     = File.expand_path(opts[:pid])
          opts[:log]     = File.expand_path(opts[:log])
        end
      end

      def self.start_application(opts)
        @@config = Dme::Filestatus::Config.init(opts[:config])

        begin
          Dme::Filestatus::Command.run(opts)
        rescue SystemExit
          # do nothing
        rescue Exception => e
          puts e.message
          exit(1)
        end
      end
    end
  end
end