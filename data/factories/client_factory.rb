require_relative '../../features/support/bucket.rb'

class Client
  attr_accessor :clientTypeId, :control, :email, :password
end

FactoryGirl.define do
  factory :client do

    trait :default do
      sequence(:email) { Bucket::stamp("Atom_email") + "@hydrogen.com" }
      password "Passw0rd!"
      control false
      clientTypeId 3
    end

    factory :default_client, traits: [:default]

  end
end
