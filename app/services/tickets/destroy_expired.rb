# frozen_string_literal: true

module Tickets
  class DestroyExpired
    EXPIRED_TIME = 15.minutes

    def destroy!
      Ticket.reserved.where('created_at < ?', EXPIRED_TIME.ago).destroy_all
    end
  end
end
