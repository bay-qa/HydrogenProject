require 'net/http'
require 'uri'
require 'json'

require_relative '../features/support/configuration'
require 'colorize'

class RestClientCall
  include RSpec::Matchers

  attr_reader :uri

  REST_METHODS = %w[get delete post put patch post]
  private_constant :REST_METHODS

  # multiple response values
  Values = Struct.new(:response, :endpoint, :params)

  REST_METHODS.each do |method|
    define_method(method) do |endpoint, params, options = {}|
      uri = URI.parse(endpoint)
      header = default_header.merge(options[:header] || {})

      net_req = Object.const_get("Net::HTTP::#{method.capitalize}").new(uri.request_uri)
      if method == 'put' || method == 'post_raw_data'
        net_req.body = JSON.generate(params) unless params == nil
        header['Content-type'] = 'application/json'
        header['Accept'] = 'text/json, application/json'
      elsif method == 'post'
        net_req.set_form_data(params) unless params == nil
      else
        #  placeholder for now...
      end
      response_time, response = nil, nil
      begin
        response_time = Benchmark.realtime do
          response = http(uri).request(req_builder(net_req, header))
        end
      rescue Exception => e
        response = e.response
      end
      print_results(endpoint, params, response_time, response)
      Values.new(response, endpoint, params)
    end
  end

  # custom post request:
  def post_raw_data(endpoint, params, options = {})
    uri = URI.parse(endpoint)
    header = default_header.merge(options[:header] || {})
    net_req = Net::HTTP::Post.new(uri.request_uri)
    net_req.body = JSON.generate(params) unless params == nil
    header['Content-type'] = 'application/json'
    header['Accept'] = 'text/json, application/json'
    response_time, response = nil, nil
    begin
      response_time = Benchmark.realtime do
        response = http(uri).request(req_builder(net_req, header))
      end
    rescue Exception => e
      response = e.response
    end
    print_results(endpoint, params, response_time, response)
    Values.new(response, endpoint, params)
  end

  def req_builder(net_req, header)
    header.each { |key, value| net_req[key] = value }
    net_req
  end

  def http(uri)
    Net::HTTP.start(uri.host, uri.port)
  end

  def default_header
    raise "Access Token missing..." if !$access_token
    {"Authorization" => "Bearer #{$access_token}"}
  end

  def get_token(username, password)
    uri = URI("#{TEST_CONFIG['token_url']}/oauth/token?grant_type=client_credentials")
    response_time, response = nil, nil
    begin
      response_time = Benchmark.realtime do
        Net::HTTP.start(uri.host, uri.port) do |http|
          request = Net::HTTP::Post.new uri.request_uri
          request.basic_auth username, password
          response = http.request request
        end
      end
    rescue Exception => e
      response = e.response
    end

    print_results(
        "#{TEST_CONFIG['token_url']}/oauth/token?grant_type=client_credentials",
        {username: username, password: password},
        response_time,
        response
    )
    expect(response.code).to eq('200')
    $access_token = JSON.parse(response.body)["access_token"]
  end

  def print_results(endpoint, params, response_time, response)
    $world.puts "Request url: #{endpoint}\n"
    $world.puts "Request params: #{params}\n"
    $world.puts "Response time: #{response_time}\n"
    $world.puts "Response code: #{response.response.code}\n"

    # truncated response up to max_chars to make output shorter when response is huge...
    max_chars = 600
    if response.response.body.to_s.size > max_chars
      $world.puts "Response body: #{response.response.body}"[0..max_chars] + "...response is to long so truncated to 600 chars\n\n"
    else
      $world.puts "Response body: #{response.response.body}\n\n"
    end
  end

end
