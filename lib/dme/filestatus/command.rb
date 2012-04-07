module Dme
  module Filestatus
    class Command

      def run(opts)
        p opts
        Dme::Filestatus::Config.informants

        Dme::Filestatus::Log.info "Foo bar"
      end
    end
  end
end