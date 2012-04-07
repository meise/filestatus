require 'dme/filestatus/config'

describe Dme::Filestatus::Config do
  before(:all) do
    @example_config = Dme::Filestatus::Config.init(Pathname('conf/config.yml.example'))
  end

  describe 'example config should be exist' do
    Dme::Filestatus::Config.init(Pathname('conf/config.yml.example'))

    Dme::Filestatus::Config.config_exist?.should eql(true)
  end

end