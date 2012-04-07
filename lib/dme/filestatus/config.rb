require 'yaml'
require 'pathname'

require 'rainbow'

module Dme
  module Filestatus
    module Config

      def self.init(config_file)
        @@config_file = Pathname(config_file) || Pathname(ENV['HOME'] + '/.filestatus/config.yml')

        if config_exist?
          parse
        else
          create_config
        end

        self
      end

      def self.config_exist?
        File.exist?(@@config_file)
      end

      def self.directories
        @@directories
      end

      def self.informants
        @@informants
      end

      protected

      def self.create_config
        unless config_exist?
          unless Dir.exist?(@@config_file.dirname)
            Dir.mkdir(@@config_file.dirname)
          end

          File.open(@@config_file, 'w') do |file|
            File.open(Gem.datadir(Dme::Filestatus::NAME) + '/config.yml.example', 'r').each_line do |example_file|
              file << example_file
            end
          end

          puts "Config file #{@@config_file} created.".color(:green)
          exit(1)
        end

        true
      end

      def self.parse
        @@config = YAML.load_file(@@config_file)

        @@directories = parse_directories
        @@informants = parse_informants
      end

      def self.parse_directories
        directories = {}
        @@config['directories'].each do |directory|
          directories["#{directory['dir']}"] = directory['files']
        end

        directories
      end

      def self.parse_informants
        informants = []

        @@config['informants'].each do |informant|

          case informant['type']
            when /xmpp/
              informants << Dme::Filestatus::Xmpp.new(informant['account'], informant['password'], informant['recipients'])
            when /mail/
              # TODO: Create Mail notifications
          end
        end

        informants
      end
    end
  end
end