@api @model @hydrogen
Feature: Client functionality

#  @test_id
  Scenario: Get all models
    Given I have authorization token
    When Request is made to "Hydrogen::ModelApi::GetAllModels" endpoint
    Then api call should succeed

#  @test_id
  Scenario: Create a model
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    And I have a "default_model" factory
    And Request is made to "Hydrogen::ModelApi::CreateNewModel" endpoint
    And api call should succeed

#  @test_id
  Scenario: Get a particular model
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    And I have a "default_model" factory
    And Request is made to "Hydrogen::ModelApi::CreateNewModel" endpoint
    And api call should succeed
    And Request is made to "Hydrogen::ModelApi::GetSingleModel" endpoint
    And api call should succeed

#  @test_id
  Scenario: Delete a particular model
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    And I have a "default_model" factory
    And Request is made to "Hydrogen::ModelApi::CreateNewModel" endpoint
    And api call should succeed
    And Request is made to "Hydrogen::ModelApi::DeleteSingleModel" endpoint
    And api call should succeed

#  @test_id
  Scenario: Edit a particular model
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    And I have a "default_model" factory
    And Request is made to "Hydrogen::ModelApi::CreateNewModel" endpoint
    And api call should succeed
    And I have a "default_model" factory
    And Request is made to "Hydrogen::ModelApi::UpdateSingleModel" endpoint
    And api call should succeed
