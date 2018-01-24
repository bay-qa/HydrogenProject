module Hydrogen

  class AllocationApi < SimpleDelegator

    ENDPOINT = "allocation"

    private_constant :ENDPOINT

    def get_all_allocation(params, query)
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
          "partnerId" => nil,
          "descriptionRetail" => nil,
          "inceptionDate" => nil,
          "partnerBenchmarkId" => nil
      }

      expect(parsed_response.class).to eq(Array)
      parsed_response.each do |ac_res|
        expect(ex_res.keys_diff(ac_res)).to be_falsey
      end
      return rest_call
    end

    def create_new_allocation(params, query)
      # POST /allocation - create an allocation
      # Sample request:
      #            {
      #                "category": "string",
      #                "clientId": 0,
      #                "description": "string",
      #                "descriptionRetail": "string",
      #                "inceptionDate": "2018-01-05T16:54:23.321Z",
      #                "isActive": true,
      #                "name": "string"
      #            }
      endpoint = "#{server_url}/#{ENDPOINT}"
      params[:clientId] = $test_glob_vars[:clientId]
      rest_call = request.post_raw_data(endpoint, params, {})
      parsed_response = JSON.parse(rest_call.response.body)
      $test_glob_vars[:allocationId] = parsed_response["id"]
      # expectations:
      # check if response has valid list of returned values
      # params passed as request body comes back in response:
      # TODO, assert inceptionDate
      expect(parsed_response.deep_include?(params.stringify_keys.except("inceptionDate"))).to be_truthy
      return rest_call
    end

    def get_single_allocation(params, query)
      # GET /allocation/{allocationId} - get a particular allocation
      endpoint = "#{server_url}/#{ENDPOINT}/#{$test_glob_vars[:allocationId]}"
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
          "partnerId" => nil,
          "descriptionRetail" => nil,
          "inceptionDate" => nil,
          "partnerBenchmarkId" => nil
      }
      expect(ex_res.keys_diff(parsed_response)).to be_falsey
      return rest_call
    end

    def delete_single_allocation(params, query)
      # DELETE /allocation/{allocationId} - delete a particular allocation
      endpoint = "#{server_url}/#{ENDPOINT}/#{$test_glob_vars[:allocationId]}"
      rest_call = request.delete(endpoint, nil, {})
      # expectations:
      expect(rest_call.response.code).to eq("204")
      return rest_call
    end

    def update_single_allocation(params, query)
      # PUT /allocation/{allocationId} - edit a particular allocation
      endpoint = "#{server_url}/#{ENDPOINT}/#{$test_glob_vars[:allocationId]}"
      rest_call = request.put(endpoint, params, {})
      parsed_response = JSON.parse(rest_call.response.body)
      # expectations:
      # check if response has valid list of returned values
      # params passed as request body comes back in response:
      expect(parsed_response.deep_include?(params.stringify_keys.except('inceptionDate'))).to be_truthy
      return rest_call
    end

    def add_model_to_allocation(params, query)
      # POST /allocation/{allocationid}/model/{modelid}/composition - add a model to an allocation
      # Sample request:
      #            {
      #                "allocationId": 0,
      #                "allocationName": "string",
      #                "modelId": 0,
      #                "modelName": "string",
      #                "weight": 0
      #            }
      endpoint = "#{server_url}/#{ENDPOINT}/#{$test_glob_vars[:allocationId]}/model/#{$test_glob_vars[:modelId]}/composition"
      params[:modelId]      = $test_glob_vars[:modelId]
      params[:allocationId] = $test_glob_vars[:allocationId]
      rest_call = request.post(endpoint, params, {})
      parsed_response = JSON.parse(rest_call.response.body)
      # expectations:
      expect(rest_call.response.code).to eq("201")
      # TODO, BUG: allocationName && modelName = nil
      # expect(parsed_response.deep_include?(params.stringify_keys.except)).to be_truthy
      return rest_call
    end

    def get_models_for_allocation(params, query)
      #  GET /allocation/{allocationid}/composition - get all models for an allocation
      endpoint = "#{server_url}/#{ENDPOINT}/#{$test_glob_vars[:allocationId]}/composition"
      rest_call = request.get(endpoint, params, {})
      parsed_response = JSON.parse(rest_call.response.body)
      # expectations:
      ex_res = {
          "createDate" => nil,
          "updateDate" => nil,
          "createdBy" => nil,
          "updatedBy" => nil,
          "id" => nil,
          "core" => nil,
          "weight" => nil,
          "allocationId" => nil,
          "allocationName" => nil,
          "modelName" => nil
      }

      expect(parsed_response.class).to eq(Array)
      parsed_response.each do |ac_res|
        expect(ex_res.keys_diff(ac_res)).to be_falsey
      end
      return rest_call
    end

    def delete_model_from_allocation(params, query)
      #  DELETE /allocation/{allocationid}/model/{modelid}/composition - remove a model from an allocation
      endpoint = "#{server_url}/#{ENDPOINT}/#{$test_glob_vars[:allocationId]}/model/#{$test_glob_vars[:modelId]}/composition"
      rest_call = request.delete(endpoint, params, {})
      # expectations:
      expect(rest_call.response.code).to eq('204')
      return rest_call
    end

  end

end
