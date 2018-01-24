module Hydrogen

  class ModelApi < SimpleDelegator

    ENDPOINT = "model"

    private_constant :ENDPOINT

    def get_all_models(params, query)
      # GET /model - get all models
      endpoint = "#{server_url}/#{ENDPOINT}"
      rest_call = request.get(endpoint, nil, {})
      parsed_response = JSON.parse(rest_call.response.body)
      # expectations:
      ex_res = {
          "createDate" => nil,
          "updateDate" => nil,
          "createdBy" => nil,
          "updatedBy" => nil,
          "id" => nil,
          "category" => nil,
          "clientId" => nil,
          "description" => nil,
          "isActive" => nil,
          "name" => nil,
          "partnerId" => nil
      }

      expect(parsed_response.class).to eq(Array)
      parsed_response.each do |ac_res|
        expect(ex_res.keys_diff(ac_res)).to be_falsey
      end
      return rest_call
    end

    def create_new_model(params, query)
      # POST /model - create an model
      # Sample request:
      # {
      #     "category": "string",
      #     "clientId": 0,
      #     "description": "string",
      #     "isActive": true,
      #     "name": "string"
      # }
      endpoint = "#{server_url}/#{ENDPOINT}"
      params[:clientId] = $test_glob_vars[:clientId]
      rest_call = request.post(endpoint, params, header: {'Authorization' => "Bearer #{$access_token}"})
      parsed_response = JSON.parse(rest_call.response.body)
      $test_glob_vars[:modelId] = parsed_response["id"]
      # expectations:
      # check if response has valid list of returned values
      # params passed as request body comes back in response:
      expect(parsed_response.deep_include?(params.stringify_keys)).to be_truthy
      return rest_call
    end

    def get_single_model(params, query)
      #  GET /model/{modelId} - get a particular model
      endpoint = "#{server_url}/#{ENDPOINT}/#{$test_glob_vars[:modelId]}"
      rest_call = request.get(endpoint, nil, {})
      parsed_response = JSON.parse(rest_call.response.body)
      # expectations:
      # check if response has valid list of returned values
      ex_res = {
          "createDate" => nil,
          "updateDate" => nil,
          "createdBy" => nil,
          "updatedBy" => nil,
          "id" => nil,
          "category" => nil,
          "clientId" => nil,
          "description" => nil,
          "isActive" => nil,
          "name" => nil,
          "partnerId" => nil
      }
      expect(ex_res.keys_diff(parsed_response)).to be_falsey
      return rest_call
    end

    def delete_single_model(params, query)
      #  DELETE /model/{modelId} - delete a particular model
      endpoint = "#{server_url}/#{ENDPOINT}/#{$test_glob_vars[:modelId]}"
      rest_call = request.delete(endpoint, nil, {})
      # expectations:
      expect(rest_call.response.code).to eq("204")
      return rest_call
    end

    def update_single_model(params, query)
      # PUT /model/{modelId} - edit a particular model
      endpoint = "#{server_url}/#{ENDPOINT}/#{$test_glob_vars[:modelId]}"
      rest_call = request.put(endpoint, params, {})
      parsed_response = JSON.parse(rest_call.response.body)
      # expectations:
      # check if response has valid list of returned values
      # params passed as request body comes back in response:
      # password looks hashed... so skipped it from assertion.
      expect(parsed_response.deep_include?(params.stringify_keys)).to be_truthy
      return rest_call
    end

  end

end
