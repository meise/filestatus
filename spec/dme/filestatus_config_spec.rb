require 'dme/filestatus/config'

describe Dme::Filestatus::Config do
  before(:all) do
    @example_config = Dme::Filestatus::Config.init(Pathname('examples/config.yml'))
  end

  describe 'example config should be exist' do
    Dme::Filestatus::Config.init(Pathname('examples/config.yml'))

    Dme::Filestatus::Config.config_exist?.should eql(true)
  end

end