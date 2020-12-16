# frozen_string_literal: true

class Api::V1::TicketsController < Api::V1::BaseController
  def index
    json_response event.tickets
  end

  def reserve
    Tickets::ReservationService.new(event, tickets_params, params[:selling_option]).reserve!
    json_response event.tickets
  rescue Tickets::SellingOptionValidation::Error => e
    json_response({ errors: e.errors }, :bad_request)
  end

  private

  def event
    @event ||= Event.find(params[:event_id])
  end

  def tickets_params
    params.permit(tickets: [:sector_id])
  end
end
