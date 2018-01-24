require_relative 'configuration'
require_relative '../../api_objects/app_initializer'
require 'factory_girl'
require_relative 'setup'
require_relative 'bucket'
require 'pry'
require 'active_support'
require 'benchmark'
require 'colorize'
require 'rspec/matchers'
require 'rspec/expectations'
require 'forgery'
require 'dotenv'
require 'require_all'
require 'time'

# load env vas:
Dotenv.load

#Retrieving the main setup interface with current configurations
c = Configuration.new
$setup = SetUp.new(c)

TEST_CONFIG = YAML.load_file('config/configuration.yml')


if TEST_CONFIG["environment"] == 'local'
  raise 'Local testing not avalible at this point...'
  # TEST_CONFIG['token_url']  = 'http://localhost:3000/'
  # TEST_CONFIG['server_url'] = 'http://localhost:3000/'
else
  TEST_CONFIG['server_url']  = "http://api.#{TEST_CONFIG['environment'].downcase}.hydrogenplatform.com:31321/api/v2"
  TEST_CONFIG['token_url']   = "http://api.#{TEST_CONFIG['environment'].downcase}.hydrogenplatform.com:31120/hydrogen"
end

TEST_CONFIG.each { |k, v| puts "Testing params: ============> #{k}:#{v}" }

#Requiring factories, so they are available in steps like 'FactoryGirl.create(:user)'
World(FactoryGirl::Syntax::Methods)
$setup.load_factories
#Loading Bucket module which is meant to contain some functions that you want to add , but probably
#not going to use that often
World(Bucket)

#Loading page factories so they are accessible in steps
$setup.load_page_objects

class HydrogentestPlatform
  def hydrogen
    AppInitializer.create_page_objects("Hydrogen")
    AppInitializer
  end
end

# htp => HydrogentestPlatform
def htp
  HydrogentestPlatform.new
end
