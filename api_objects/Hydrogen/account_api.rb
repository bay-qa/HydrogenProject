module Hydrogen

  class AccountApi < SimpleDelegator

    ENDPOINT = "account"

    private_constant :ENDPOINT

    def get_all_account_types(params, query)
      #  GET /accounttypes - get all account types
      endpoint = "#{server_url}/#{ENDPOINT}types"
      rest_call = request.get(endpoint, nil, {})
     parsed_response = JSON.parse(rest_call.response.body)
      # expectations:
      # check if response nas valid list of returned values
      ex_res = {
          "id" => nil,
          "category" => nil,
          "code" => nil,
          "displayName" => nil,
          "isActive" => nil,
          "isTaxable" => nil,
          "name" => nil,
          "shortName" => nil,
          "subcategory" => nil,
          "partnerId" => nil,
          "taxable" => nil,
          "active" => nil
      }
      expect(parsed_response.class).to eq(Array)
      parsed_response.each do |ac_res|
        expect(ex_res.keys_diff(ac_res)).to be_falsey
      end
      return rest_call
    end

    def get_all_accounts(params, query)
      # GET /{baseUrl}/client/{clientId}/account - get all accounts under a client
      endpoint = "#{server_url}/client/#{$test_glob_vars[:clientId]}/#{ENDPOINT}"
      rest_call = request.get(endpoint, nil, {})
      parsed_response = JSON.parse(rest_call.response.body)
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
      return rest_call
    end

    def create_new_account(params, query)
      # POST /{baseUrl}/client/{clientId}/account - create an account under a client
      #  Sample request:
      #             {
      #                 "accountTypeId": 1,
      #                 "clientAccountAssociationId": 1,
      #                 "clientId": 0,
      #                 "extraInfo": "string",
      #                 "name": "string",
      #                 "signatureData": "string"
      #             }
      # :TODO
      # 1. missing required param "goalId",
      # 2. signatureData => Base64
      # 3. post data request are not consistent...(form_data, raw_json)

      endpoint = "#{server_url}/client/#{$test_glob_vars[:clientId]}/#{ENDPOINT}"
      params[:clientId] = $test_glob_vars[:clientId]
      rest_call = request.post_raw_data(endpoint, params, {})
      parsed_response = JSON.parse(rest_call.response.body)
      $test_glob_vars[:clientAccountId] = parsed_response["id"]
      # expectations:
      # check if response has valid list of returned values
      # params passed as request body comes back in response:
      expect(parsed_response.deep_include?(params.stringify_keys.except("clientId"))).to be_truthy
      return rest_call
    end

    def get_single_account(params, query)
      # GET /{baseUrl}/client/{clientId}/account/{accountId} - get a particular client account
      endpoint = "#{server_url}/client/#{$test_glob_vars[:clientId]}/#{ENDPOINT}/#{$test_glob_vars[:clientAccountId]}"
      rest_call = request.get(endpoint, nil, {})
      parsed_response = JSON.parse(rest_call.response.body)
      # expectations:
      # check if response has valid list of returned values
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
      expect(ex_res.keys_diff(parsed_response)).to be_falsey
      return rest_call
    end

    def delete_single_account(params, query)
      # DELETE /{baseUrl}/client/{clientId}/account/{accountId} - delete a particular client account
      endpoint = "#{server_url}/client/#{$test_glob_vars[:clientId]}/#{ENDPOINT}/#{$test_glob_vars[:clientAccountId]}"
      rest_call = request.delete(endpoint, nil, {})
      # expectations:
      expect(rest_call.response.code).to eq("204")
      return rest_call
    end

    def update_single_account(params, query)
      # PUT /{baseUrl}/client/{clientId}/account/{accountId} - edit a particular client account
      endpoint = "#{server_url}/client/#{$test_glob_vars[:clientId]}/#{ENDPOINT}/#{$test_glob_vars[:clientAccountId]}"
      rest_call = request.put(endpoint, params, {})
      parsed_response = JSON.parse(rest_call.response.body)
      # expectations:
      # check if response has valid list of returned values
      # params passed as request body comes back in response:
      expect(parsed_response.deep_include?(params.stringify_keys)).to be_truthy
      return rest_call
    end

  end

end
