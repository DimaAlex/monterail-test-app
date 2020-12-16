# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tickets::ReservationService, type: :service do
  describe '#reserve!' do
    subject(:reserve) { described_class.new(event, { sector_id: sector.id }, 'all').reserve! }

    let(:event) { create(:event, :with_sector) }
    let(:sector) { event.sectors.first }

    before do
      allow(Tickets::SellingOptionValidation).to receive_message_chain(:new, :validate!).and_return(true)
      reserve
    end

    it 'creates ticket' do
      ticket = event.tickets.first

      expect(ticket).to be_reserved
      expect(ticket.sector_id).to eq sector.id
      expect(ticket.event_id).to eq event.id
    end
  end
end
