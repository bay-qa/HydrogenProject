@api @allocation @hydrogen
Feature: Allocation functionality

#  @test_id
  Scenario: Get all allocations
    Given I have authorization token
    When Request is made to "Hydrogen::AllocationApi::GetAllAllocation" endpoint
    Then api call should succeed

#  @test_id
  Scenario: Create a allocation
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    And I have a "default_allocation" factory
    When Request is made to "Hydrogen::AllocationApi::CreateNewAllocation" endpoint
    Then api call should succeed

#  @test_id
  Scenario: Get a particular allocation
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    And I have a "default_allocation" factory
    And Request is made to "Hydrogen::AllocationApi::CreateNewAllocation" endpoint
    And api call should succeed
    When Request is made to "Hydrogen::AllocationApi::GetSingleAllocation" endpoint
    Then api call should succeed

#  @test_id
  Scenario: Delete a particular allocation
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    And I have a "default_allocation" factory
    And Request is made to "Hydrogen::AllocationApi::CreateNewAllocation" endpoint
    And api call should succeed
    When Request is made to "Hydrogen::AllocationApi::DeleteSingleAllocation" endpoint
    Then api call should succeed

#  @test_id
  Scenario: Edit a particular allocation
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    And I have a "default_allocation" factory
    And Request is made to "Hydrogen::AllocationApi::CreateNewAllocation" endpoint
    And api call should succeed
    And I have a "default_allocation" factory
    When Request is made to "Hydrogen::AllocationApi::UpdateSingleAllocation" endpoint
    Then api call should succeed

#  @test_id
  Scenario: Add a model to an allocation
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    And I have a "default_allocation" factory
    And Request is made to "Hydrogen::AllocationApi::CreateNewAllocation" endpoint
    And api call should succeed
    And I have a "default_model" factory
    And Request is made to "Hydrogen::ModelApi::CreateNewModel" endpoint
    And I have a "test_model" factory
    When Request is made to "Hydrogen::AllocationApi::AddModelToAllocation" endpoint
    Then api call should succeed

#  @test_id
  Scenario: Get all models for an allocation
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    And I have a "default_allocation" factory
    And Request is made to "Hydrogen::AllocationApi::CreateNewAllocation" endpoint
    And api call should succeed
    And I have a "default_model" factory
    And Request is made to "Hydrogen::ModelApi::CreateNewModel" endpoint
    And I have a "test_model" factory
    When Request is made to "Hydrogen::AllocationApi::AddModelToAllocation" endpoint
    Then api call should succeed
    When Request is made to "Hydrogen::AllocationApi::GetModelsForAllocation" endpoint
    Then api call should succeed

#  @test_id
  Scenario: Remove a model from an allocation
    Given I have authorization token
    And I have a "default_client" factory
    And Request is made to "Hydrogen::ClientApi::CreateNewClient" endpoint
    And api call should succeed
    And I have a "default_allocation" factory
    And Request is made to "Hydrogen::AllocationApi::CreateNewAllocation" endpoint
    And api call should succeed
    And I have a "default_model" factory
    And Request is made to "Hydrogen::ModelApi::CreateNewModel" endpoint
    And I have a "test_model" factory
    And Request is made to "Hydrogen::AllocationApi::AddModelToAllocation" endpoint
    And api call should succeed
    When Request is made to "Hydrogen::AllocationApi::DeleteModelFromAllocation" endpoint
    Then api call should succeed
