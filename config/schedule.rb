# frozen_string_literal: true

every 1.minute do
  rake 'tickets:destroy_expired_reservations'
end
