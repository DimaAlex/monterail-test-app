# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TicketsController, type: :controller do
  describe 'GET /api/v1/events/:event_id/tickets' do
    it_behaves_like 'authenticable', :index, { event_id: 1 }

    context 'when request is successful' do
      include_context 'with apikey'

      let!(:event) { create(:event, :with_tickets) }
      let(:json_response) { JSON.parse(response.body, symbolize_names: true) }
      let(:expected_response_body) do
        event.tickets.map do |ticket|
          { id: ticket.id, status: ticket.status }
        end
      end

      it 'returns correct response' do
        get :index, params: { event_id: event.id }
        expect(json_response).to eq(expected_response_body)
      end
    end
  end
end
