class ApiHelper

  include RSpec::Matchers

  attr_accessor :server_url, :htp, :request

  def initialize(server_url)
    @server_url     = server_url
    @htp = HydrogentestPlatform.new
    @request = RestClientCall.new
  end

  # some widely used methods can go below...,
  # for example math id regex for an assertion:
  def uuid_regex
    #match uuid format: "817d925b-651c-41e6-9518-0d3ba4d46acf".match uuid_regex => not nil
    /^(?i)[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/
  end

end
