# frozen_string_literal: true

namespace :tickets do
  desc 'Destroys expired reservations'
  task destroy_expired_reservations: :environment do
    DestroyExpiredTicketsJob.perform_later
  end
end
