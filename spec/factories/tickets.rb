# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do

    before(:create) do |ticket|
      create(:event).yield_self do |event|
        sector = create(:sector, event: event)
        ticket.assign_attributes(event: event, sector: sector)
      end
    end
  end
end
