# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { Faker::FunnyName.name }

    trait :with_tickets do
      after(:create) do |event, evaluator|
        create_list :ticket, 2, event: event, sector: create(:sector, event: event)
      end
    end
  end
end
