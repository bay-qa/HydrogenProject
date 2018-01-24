require_relative '../../features/support/bucket.rb'

class Account
  attr_accessor :accountTypeId, :clientAccountAssociationId, :clientId, :extraInfo, :name, :signatureData
end

FactoryGirl.define do
  factory :account do

    trait :default do
      accountTypeId 203
      clientAccountAssociationId 1
      extraInfo 'foo'
      sequence(:name) { Bucket::stamp("Atom_name") }
      # signatureData 'foo'
      goalId [574201248]
    end

    factory :default_account, traits: [:default]

  end
end

