# frozen_string_literal: true

class DestroyExpiredTicketsJob < ApplicationJob
  queue_as :default

  def perform
    Tickets::DestroyExpired.new.destroy!
  end
end
