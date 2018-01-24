module Hydrogen

  class PortfolioApi < SimpleDelegator

    ENDPOINT = "portfolio"

    private_constant :ENDPOINT

    def get_all_portfolio_types(params, query)
      #  GET /portfoliotype - get portfolio types
      endpoint = "#{server_url}/#{ENDPOINT}type"
      rest_call = request.get(endpoint, nil, {})
      parsed_response = JSON.parse(rest_call.response.body)
      # expectations:
      # check if response nas valid list of returned values
      ex_res = {
          "createDate" => nil,
          "updateDate" => nil,
          "createdBy" => nil,
          "id" => nil,
          "type" => nil
      }
      expect(parsed_response.class).to eq(Array)
      parsed_response.each do |ac_res|
        expect(ex_res.keys_diff(ac_res)).to be_falsey
      end
      return rest_call
    end

    def get_all_accounts(params, query)
      # GET /{baseUrl}/client/{clientId}/account - get all accounts under a client
      endpoint = "#{server_url}/client/#{$test_glob_vars[:client_id]}/#{ENDPOINT}"
      response = request.get(endpoint, nil, {})
      # print response info
      print_response_info({method: 'GET', endpoint: endpoint, params: nil, response: response})
      parsed_response = JSON.parse(response.body)
      # expectations:
      # check if response nas valid list of returned values
      ex_res = {
          "clientId" => nil,
          "clientAccountAssociationId" => nil,
          "extraInfo" => nil,
          "clientAccountId" => nil,
          "name" => nil,
          "createDate" => nil,
          "managed" => nil,
          "accountType" => nil,
          "goalId" => nil
      }
      expect(parsed_response.class).to eq(Array)
      parsed_response.each do |ac_res|
        expect(ex_res.keys_diff(ac_res)).to be_falsey
      end
      return response
    end

    def create_new_portfolio(params, query) #in progress
      # POST /client/{clientid}/account/{accountid}/portfolio - create a portfolio under an account
      #  Sample request:
      #            params =  {
      #                 "clientAccountId": 795479998,
      #                 "description": "foo",
      #                 "name": "Atom_name01152018165208404",
      #                 "percentage": 10,
      #                 "portfolioTypeId": 1
      #             }
      endpoint = "#{server_url}/client/#{$test_glob_vars[:clientId]}/account/#{$test_glob_vars[:clientAccountId]}/#{ENDPOINT}"
      params[:clientAccountId] = $test_glob_vars[:clientAccountId]
      response = request.post_raw_data(endpoint, params, {})
      # print response info
      print_response_info({method: 'POST', endpoint: endpoint, params: params, response: response})
      parsed_response = JSON.parse(response.body)
      $test_glob_vars[:portfolio_id] = parsed_response["id"]
      # expectations:
      # check if response has valid list of returned values
      # params passed as request body comes back in response:
      expect(parsed_response.deep_include?(params.stringify_keys)).to be_truthy
      return response
    end

  end

end
