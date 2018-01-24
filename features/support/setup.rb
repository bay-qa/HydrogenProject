require 'require_all'

class SetUp

  def initialize(config)
    @config = config
  end

  def load_page_objects
    require_all 'api_objects'
  end

  def load_factories
    path = File.dirname(__FILE__) + "/../../data"
    data_objects = '/factories'
    require_all path + data_objects
    FactoryGirl.definition_file_paths = %w(path)
    FactoryGirl.find_definitions
    p "FACTORIES ARE LOADED"
  end

  def config
    @config
  end

  def environment
    @config.get_param('environment')
  end

end
