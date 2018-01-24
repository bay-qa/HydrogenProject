Then(/^api call should (succeed|fail)$/) do |condition|
  case condition
    when 'succeed'
      # raises error message in terminal if response has error and response is NOT successful
      # if @response.is_a?(Net::HTTPSuccess) && @response.body['error']
      if !(200..204).include? @rest_call.response.code.to_i
        raise 'Request failed, expected success'
      end
    when 'fail'
      # raises error message in terminal if response does NOT have error and response IS successful
      if @rest_call.response.is_a?(Net::HTTPSuccess)
        raise 'Request succeeded, expected failure' unless @rest_call.response.code == '207'
      end
  end
end

And(/^(Request|request) is made to "([^"]*)" endpoint$/) do |condition, string, *table|
  # if table , => hash with params
  if table.size != 0
    query = table[0].rows_hash
  else
    query = nil
  end

  arr = string.split("::")
  hash = {"service": arr[0], "api_class": arr[1], "method": arr[2]}
  param = hash.each { |k, v| hash[k] = v.underscore }

  response, response_time = nil, nil
  response_time = Benchmark.realtime do
    response = htp.instance_eval(param[:service]).instance_eval(param[:api_class]).send(param[:method], @params, query)
  end
  @rest_call = response
  @parsed_response = JSON.parse(@rest_call.response.body) unless @rest_call.response.body == nil || @rest_call.response.body == ""
  @params = {} unless condition == "request"
end

When(/^Parameters are supplied$/) do |table|
  @params = table.rows_hash
end

And(/^these response ("[^"]*")? keys should have value:$/) do |response_node, table|
  if response_node.nil?
    parsed_response = @parsed_response
  else
    parsed_response = @parsed_response[response_node.gsub! /"/, '']
  end
  table.raw.each do |row|
    expect(parsed_response[row[0]][0]).not_to be_nil
  end
end

And(/^response error massagge should be:$/) do |table|
  expect(JSON.parse(@rest_call.response.body)['errors']).to be == (table.raw[0][1]) if JSON.parse(@rest_call.response.body)['errors'] #hp error response
  expect(JSON.parse(@rest_call.response.body)['error']).to be == (table.raw[0][0]) if JSON.parse(@rest_call.response.body)['error'] #ellis island error response
end

When(/^Test description: "([^"]*)"$/) do |comment|
  puts "#{comment}\n"
end

And(/^response code is "([^"]*)" and response body "([^"]*)" key should have:$/) do |response_code, obj, table|
  response = table.raw[0][0]
  value = nil
  if response.match(/^\{|\[/) !=nil
    value = eval(response)
  else
    value = response
  end
  expect(@rest_call.response.code).to eq(response_code)
  expect(@parsed_response[obj] == (un_symbolize(value)) ||
             # @parsed_response == value ||
             @parsed_response[obj].include?(un_symbolize(value)) ||
             (un_symbolize(value)[obj] != nil && @parsed_response[obj].include?(un_symbolize(value)[obj])) ||
             (value != "" && @parsed_response[obj].to_s.include?(un_symbolize(value)))).to be_truthy
end

And(/^Response has (not )?id:$/) do |condition, table|
  if condition
    expect(@rest_call.response.body.to_s.include? eval("$test_glob_vars[:#{table.raw[0][0]}]")).to be_falsey
  else
    expect(@rest_call.response.body.to_s.include? eval("$test_glob_vars[:#{table.raw[0][0]}]")).to be_truthy
  end
end

