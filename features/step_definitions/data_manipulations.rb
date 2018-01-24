Given(/^I have a "([^"]*)" factory$/) do |factory_name, *table|
  params = {}
  if table.size != 0
    params = table[0].rows_hash
    Bucket::data_creator(params)
  end
  @params = FactoryGirl.attributes_for(factory_name.to_sym, params)
  instance_variable_set("@#{factory_name}", @params.dup)
end


