# frozen_string_literal: true

class Api::V1::TicketsController < Api::V1::BaseController
  def index
    json_response event.tickets
  end

  private

  def event
    @event ||= Event.find(params[:event_id])
  end
end
