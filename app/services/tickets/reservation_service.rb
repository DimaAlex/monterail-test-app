# frozen_string_literal: true

module Tickets
  class ReservationService
    def initialize(event, tickets_params, selling_option)
      @event = event
      @tickets_params = tickets_params
      @selling_option = selling_option
    end

    def reserve!
      validate!

      reserve_tickets
    end

    private

    attr_reader :event, :tickets_params, :selling_option

    def validate!
      SellingOptionValidation.new(event, tickets_params, selling_option).validate!
    end

    def reserve_tickets
      event.tickets.create!(tickets_params)
    end
  end
end
