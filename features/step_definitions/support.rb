And(/^binding pry$/) do
  binding.pry
end

When(/^I have authorization token$/) do
  RestClientCall.new.get_token(ENV["USER_NAME"], ENV["USER_PASSWORD"])
end
