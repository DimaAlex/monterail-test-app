# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { Faker::FunnyName.name }

    trait :with_tickets do
      after(:create) do |event, _evaluator|
        create_list :ticket, 2, event: event, sector: create(:sector, event: event)
      end
    end

    trait :with_sector do
      after(:create) do |event, _evaluator|
        create(:sector, event: event, title: 'sector1', tickets_amount: 10)
      end
    end
  end
end
