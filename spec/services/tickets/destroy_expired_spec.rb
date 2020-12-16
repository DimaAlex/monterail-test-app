# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tickets::DestroyExpired, type: :service do
  describe '#destroy!' do
    subject(:destroy) { described_class.new.destroy! }

    before do
      create(:ticket, created_at: 10.minutes.ago)
      create(:ticket, created_at: 20.minutes.ago)
      create(:ticket, created_at: 10.minutes.ago, status: :paid)
      destroy
    end

    it 'destroys all tickets which were reserved 15 minutes ago' do
      expect(Ticket.count).to eq 2
    end
  end
end
