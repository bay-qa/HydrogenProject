module Hydrogen

  class ClientApi < SimpleDelegator

    ENDPOINT = "client"

    private_constant :ENDPOINT

    def get_all_client_types(params, query)
      endpoint = "#{server_url}/#{ENDPOINT}types"
      rest_call = request.get(endpoint, nil, {})
      parsed_response = JSON.parse(rest_call.response.body)
      # expectations:
      ex_res = {
          "createDate" => nil,
          "updateDate" => nil,
          "createdBy" => nil,
          "updatedBy" => nil,
          "id" => nil,
          "type" => nil
      }
      expect(parsed_response.class).to eq(Array)
      parsed_response.each do |ac_res|
        expect(ex_res.keys_diff(ac_res)).to be_falsey
      end
      return rest_call
    end

    def get_all_clients(params, query)
      endpoint = "#{server_url}/#{ENDPOINT}"
      rest_call = request.get(endpoint, nil, {})
      parsed_response = JSON.parse(rest_call.response.body)
      # expectations:
      # check if response nas valid list of returned values
      ex_res = {
          "createDate" => nil,
          "updateDate" => nil,
          "createdBy" => nil,
          "updatedBy" => nil,
          "id" => nil,
          "control" => nil,
          "email" => nil,
          "password" => nil,
          "partnerId" => nil,
          "clientTypeId" => nil,
          "isActive" => nil,
          "token" => nil
      }
      expect(parsed_response.class).to eq(Array)
      parsed_response.each do |ac_res|
        expect(ex_res.keys_diff(ac_res)).to be_falsey
      end
      return rest_call
    end

    def create_new_client(params, query)
      # POST /{baseUrl}/client - create a client
      endpoint = "#{server_url}/#{ENDPOINT}"
      rest_call = request.post(endpoint, params, header: {'Authorization' => "Bearer #{$access_token}"})
      return rest_call unless (200..204).include? rest_call.response.code.to_i
      parsed_response = JSON.parse(rest_call.response.body)
      $test_glob_vars[:clientId] = parsed_response["id"]
      # expectations:
      # check if response has valid list of returned values
      # params passed as request body comes back in response:
      # password looks hashed... so skipped it from assertion.
      expect(parsed_response.deep_include?(params.stringify_keys.except("password"))).to be_truthy
      return rest_call
    end

    def get_single_client(params, query)
      # GET /{baseUrl}/client/{clientId} - get a particular client
      endpoint = "#{server_url}/#{ENDPOINT}/#{$test_glob_vars[:clientId]}"
      rest_call = request.get(endpoint, nil, header: {'Authorization' => "Bearer #{$access_token}"})
      parsed_response = JSON.parse(rest_call.response.body)
      # expectations:
      # check if response has valid list of returned values
      ex_res = {
          "createDate" => nil,
          "updateDate" => nil,
          "createdBy" => nil,
          "updatedBy" => nil,
          "id" => nil,
          "control" => nil,
          "email" => nil,
          "password" => nil,
          "partnerId" => nil,
          "clientTypeId" => nil,
          "isActive" => nil,
          "token" => nil
      }
      expect(ex_res.keys_diff(parsed_response)).to be_falsey
      return rest_call
    end

    def delete_single_client(params, query)
      # DELETE /{baseUrl}/client/{clientId} - delete a particular client
      endpoint = "#{server_url}/#{ENDPOINT}/#{$test_glob_vars[:clientId]}"
      rest_call = request.delete(endpoint, nil, {})
      # expectations:
      expect(rest_call.response.code).to eq("204")
      return rest_call
    end

    def update_single_client(params, query)
      # PUT /{baseUrl}/client - update a single client
      endpoint = "#{server_url}/#{ENDPOINT}/#{$test_glob_vars[:clientId]}"
      rest_call = request.put(endpoint, params, {})
      parsed_response = JSON.parse(rest_call.response.body)
      $test_glob_vars[:clientId] = parsed_response["id"]
      # expectations:
      # check if response has valid list of returned values
      # params passed as request body comes back in response:
      # password looks hashed... so skipped it from assertion.
      expect(parsed_response.deep_include?(params.stringify_keys.except("password"))).to be_truthy
      return rest_call
    end

  end

end
