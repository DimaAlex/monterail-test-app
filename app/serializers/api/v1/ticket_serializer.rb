# frozen_string_literal: true

class Api::V1::TicketSerializer < ActiveModel::Serializer
  attributes :id, :status
end
