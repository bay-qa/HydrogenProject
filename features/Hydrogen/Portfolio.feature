@api @portfolio @hydrogen
Feature: Portfolio functionality

#  @test_id
  Scenario: Get portfolio types
    Given I have authorization token
    When Request is made to "Hydrogen::PortfolioApi::GetAllPortfolioTypes" endpoint
    Then api call should succeed

  @dont @wip #skip the scenario, work in progress
  Scenario: Create a portfolio under an account
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    And I have a "default_account" factory
    When Request is made to "Hydrogen::AccountApi::CreateNewAccount" endpoint
    Then api call should succeed

    And I have a "default_portfolio" factory
    And Request is made to "Hydrogen::PortfolioApi::CreateNewPortfolio" endpoint
    And api call should succeed
