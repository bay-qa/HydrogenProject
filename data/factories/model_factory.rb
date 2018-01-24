require_relative '../../features/support/bucket.rb'

class Model
  attr_accessor :name, :isActive, :description, :category, :allocationName, :modelName, :weight
end

FactoryGirl.define do
  factory :model do

    trait :default do
      sequence(:name) { Bucket::stamp("Atom_name") }
      isActive true
      description { Forgery('lorem_ipsum').paragraphs(1) }
      category "foo"
    end

    trait :test do
      sequence(:allocationName) { Bucket::stamp("Atom_allocation_name") }
      sequence(:modelName) { Bucket::stamp("Atom_model_name") }
      weight 0
    end

    factory :default_model, traits: [:default]
    factory :test_model, traits: [:test]

  end
end
