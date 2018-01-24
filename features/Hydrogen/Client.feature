@api @client @hydrogen
Feature: Client functionality

#  @test_id
  Scenario: Get all client types
    Given I have authorization token
    When Request is made to "Hydrogen::ClientApi::GetAllClientTypes" endpoint
    Then api call should succeed

#  @test_id
  Scenario: Get all clients
    Given I have authorization token
    And I have a "default_client" factory
    When Request is made to "Hydrogen::ClientApi::GetAllClients" endpoint
    Then api call should succeed

#  @test_id
  @test
  Scenario: Create a client
    Given I have authorization token
    And I have a "default_client" factory
    When Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    Then api call should succeed

#  @test_id
  Scenario: Get a particular client
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    When Request is made to "Hydrogen::ClientApi::GetSingleClient" endpoint
    Then api call should succeed

#  @test_id
  Scenario: Delete a particular client
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    When Request is made to "Hydrogen::ClientApi::DeleteSingleClient" endpoint
    Then api call should succeed

#  @test_id
  Scenario: Edit a particular client
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    And I have a "default_client" factory
    When Request is made to "Hydrogen::ClientApi::UpdateSingleClient" endpoint
    Then api call should succeed

  Scenario Outline: Create a client, negative scenarios
    Given I have authorization token
    And I have a "default_client" factory
      | <key> | <value> |
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should fail
    Examples:
      | key          | value | comment         |
#      @test_id
      | clientTypeId | true  | wrong data type |
#      @test_id
      | email        |       | empty string    |
