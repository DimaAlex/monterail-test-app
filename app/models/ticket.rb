# frozen_string_literal: true

# == Schema Information
#
# Table name: tickets
#
#  id         :integer          not null, primary key
#  paid_at    :datetime
#  status     :integer          default("reserved"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :integer
#  sector_id  :integer          not null
#
# Indexes
#
#  index_tickets_on_event_id   (event_id)
#  index_tickets_on_sector_id  (sector_id)
#
# Foreign Keys
#
#  event_id   (event_id => events.id)
#  sector_id  (sector_id => sectors.id)
#
class Ticket < ApplicationRecord
  belongs_to :event
  belongs_to :sector

  enum status: %i[reserved paid]
end
