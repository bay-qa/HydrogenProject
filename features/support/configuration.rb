require 'json'
require 'yaml'

class Configuration

  def initialize
    @config_path = 'config/configuration.yml'
    @conf = get_configs(@config_path)
  end

  def get_param(param, default=nil)
    param_value = @conf[param]
    if param_value.nil? || param_value.empty?
      default
    else
      param_value
    end
  end

  def get_configs(full_name)
    if File.exist? full_name
      YAML.load_file full_name
    end
  end

  def set_configs(configs)
    config_path = 'config/configuration.yml'
    data = YAML.load_file config_path
    begin
      jconf = JSON.parse configs

      new_hash = {}
      data.each do |key, value|
        jconf_value = jconf[key]

        if jconf_value.nil?
          new_hash.merge!({key => value})
        else
          if jconf_value.is_a?(Hash) and value.is_a?(Hash)
            temp_value = value.merge(jconf_value)
          elsif jconf_value.is_a?(Array) and value.is_a?(Array)
            temp_value = jconf_value + value
          else
            temp_value = jconf_value
          end
          new_hash.merge!({key => temp_value})
        end
      end

      File.open(config_path, 'w') { |f| YAML.dump(new_hash, f) }
    rescue Exception => e
      puts e
    end
  end

end

# you can set custom TEST_CONF hash with params:
if __FILE__==$0
  hash = ENV['TEST_CONF']
  puts "Initalizing configuration using: ============> #{hash}"
  Configuration.new.set_configs(hash)
end
