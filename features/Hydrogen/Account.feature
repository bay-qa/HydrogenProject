@api @account @hydrogen
Feature: Account functionality

#  @test_id
  Scenario: Get all accounts under a client
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    And I have a "default_account" factory
    When Request is made to "Hydrogen::AccountApi::CreateNewAccount" endpoint
    Then api call should succeed
    And I have a "default_account" factory
    When Request is made to "Hydrogen::AccountApi::GetAllAccounts" endpoint
    Then api call should succeed

#  @test_id
  Scenario: Get all account types
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    And I have a "default_account" factory
    When Request is made to "Hydrogen::AccountApi::CreateNewAccount" endpoint
    Then api call should succeed
    And I have a "default_account" factory
    When Request is made to "Hydrogen::AccountApi::GetAllAccountTypes" endpoint
    Then api call should succeed

#  @test_id
  Scenario: Create a account
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    And I have a "default_account" factory
    When Request is made to "Hydrogen::AccountApi::CreateNewAccount" endpoint
    Then api call should succeed

#  @test_id
  Scenario: Get a particular account
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    And I have a "default_account" factory
    When Request is made to "Hydrogen::AccountApi::CreateNewAccount" endpoint
    Then api call should succeed
    When Request is made to "Hydrogen::AccountApi::GetSingleAccount" endpoint
    Then api call should succeed

#  @test_id
  Scenario: Delete a particular account
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    And I have a "default_account" factory
    When Request is made to "Hydrogen::AccountApi::CreateNewAccount" endpoint
    Then api call should succeed
    When Request is made to "Hydrogen::AccountApi::DeleteSingleAccount" endpoint
    Then api call should succeed

#  @test_id
  Scenario: Edit a particular account
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    And I have a "default_account" factory
    When Request is made to "Hydrogen::AccountApi::CreateNewAccount" endpoint
    Then api call should succeed
    And I have a "default_account" factory
    When Request is made to "Hydrogen::AccountApi::UpdateSingleAccount" endpoint
    Then api call should succeed
