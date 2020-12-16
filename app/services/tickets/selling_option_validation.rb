# frozen_string_literal: true

module Tickets
  class SellingOptionValidation
    class Error < StandardError
      attr_accessor :errors

      def initialize(errors)
        @errors = errors || {}
        super
      end
    end

    def initialize(event, tickets_params, selling_option)
      @event = event
      @tickets_params = tickets_params
      @selling_option = selling_option
    end

    def validate!
      return if errors.empty?

      raise Error, errors
    end

    private

    attr_reader :event, :tickets_params, :selling_option

    def errors
      @errors ||=
        case selling_option
        when 'all' then validate_all!
        when 'event' then validate_even!
        when 'avoid_one' then validate_avoid_one!
        else
          raise Error, 'There is no such selling option.'
        end
    end

    def validate_all!
      validate_tickets do |sector_id, tickets|
        [
          sector_id,
          validate_condition(
            sector_by(sector_id).tickets_amount == tickets.count,
            'Not all tickets are passed for the sector.'
          )
        ]
      end
    end

    def validate_even!
      validate_tickets do |sector_id, tickets|
        [
          sector_id,
          validate_condition(
            tickets.count.even?,
            'Amount of tickets should be even for the sector.'
          )
        ]
      end
    end

    def validate_avoid_one!
      validate_tickets do |sector_id, tickets|
        [
          sector_id,
          validate_condition(
            sector_by(sector_id).tickets_amount - 1 != tickets.count,
            'You can not pass leave one ticket.'
          )
        ]
      end
    end

    def validate_condition(is_valid_tickets_amount, error_msg)
      return if is_valid_tickets_amount

      error_msg
    end

    def tickets_by_sector_id
      @tickets_by_sector_id ||= tickets_params.group_by { |t| t[:sector_id] }
    end

    def validate_tickets(&block)
      tickets_by_sector_id.map do |sector_id, tickets|
        block.call(sector_id, tickets)
      end.to_h.reject { |_k, v| v.blank? }
    end

    def sector_by(sector_id)
      event.sectors.find(sector_id)
    end
  end
end
