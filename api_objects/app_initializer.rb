class AppInitializer

  class << self

    def create_method(name, &block)
      self.class.send(:define_method, name, &block)
    end

    def create_page_objects(service_name)
      my_service = Object.const_get(service_name)
      object_list = my_service.constants.select { |c| my_service.const_get(c).is_a? Class }
      app_builder = ApiHelper.new(TEST_CONFIG['server_url'])
      object_list.each do |o_class|
        instance_name = o_class.to_s.tableize.singularize
        my_object = Object.const_get("#{service_name}::#{o_class}")
        instance_variable_set("@#{instance_name}", my_object.new(app_builder))
        self.create_method(instance_name.to_sym) {
          instance_variable_get("@#{instance_name}")
        }

      end

    end
  end

end

