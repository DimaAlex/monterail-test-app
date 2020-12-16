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

    describe 'POST /api/v1/events/:event_id/tickets/reserve' do
      include_context 'with apikey'

      subject(:reserve) do
        post :reserve, params: { event_id: event.id, selling_option: 'all' }.merge(tickets_params)
      end

      let!(:event) { create(:event) }
      let(:tickets_params) do
        {
          tickets: [{ sector_id: 1 }]
        }
      end
      let(:reservation_service_double) { instance_double(Tickets::ReservationService) }

      before do
        allow(Tickets::ReservationService).to receive(:new)
          .and_return(reservation_service_double)
        allow(reservation_service_double).to receive(:reserve!)
      end

      it 'invokes reservation service' do
        expect(reservation_service_double).to receive(:reserve!)
        reserve
      end

      it 'returns correct http code' do
        reserve
        expect(response.code).to eq '200'
      end

      context 'when an error occurs' do
        let(:errors) { { sector_id: 'error message' } }

        before do
          allow(reservation_service_double).to receive(:reserve!) do
            raise Tickets::SellingOptionValidation::Error, errors
          end
          reserve
        end

        it 'returns correct http code' do
          expect(response.code).to eq '400'
        end

        it 'returns errors' do
          expect(response.body).to eq({ errors: errors }.to_json)
        end
      end
    end
  end
end
