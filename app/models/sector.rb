# frozen_string_literal: true

# == Schema Information
#
# Table name: sectors
#
#  id             :integer          not null, primary key
#  tickets_amount :integer          default(0), not null
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  event_id       :integer          not null
#
# Indexes
#
#  index_sectors_on_event_id  (event_id)
#
# Foreign Keys
#
#  event_id  (event_id => events.id)
#
class Sector < ApplicationRecord
  belongs_to :event
  has_many :tickets
end
