require_relative '../../features/support/bucket.rb'

class Portfolio
  attr_accessor :clientAccountId, :description, :name, :percentage, :portfolioTypeId
end

FactoryGirl.define do
  factory :portfolio do

    trait :default do
      sequence(:name) { Bucket::stamp("Atom_name") }
      description { Forgery('lorem_ipsum').paragraphs(1) }
      percentage 0
      portfolioTypeId 1
    end

    factory :default_portfolio, traits: [:default]

  end
end
