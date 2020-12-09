# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :sector

  enum status: %i[reserved paid]
end
