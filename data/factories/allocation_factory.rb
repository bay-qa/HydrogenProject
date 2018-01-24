require_relative '../../features/support/bucket.rb'

class Allocation
  attr_accessor :name, :isActive, :inceptionDate, :descriptionRetail, :description, :category
end

FactoryGirl.define do
  factory :allocation do

    trait :default do
      sequence(:name) { Bucket::stamp("Atom_name") }
      isActive true
      sequence(:inceptionDate) { Time.now.iso8601 }
      descriptionRetail { Forgery('lorem_ipsum').paragraphs(1) }
      description { Forgery('lorem_ipsum').paragraphs(1) }
      category "foo"
    end

    factory :default_allocation, traits: [:default]

  end
end
