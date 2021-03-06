# frozen_string_literal: true

FactoryBot.define do
  factory :sector do
    title { "#{Array('A'..'Z').sample} #{id}" }
    tickets_amount { Faker::Number.number(digits: 2) }
  end
end
