class AddReferenceBetweenEventAndTicket < ActiveRecord::Migration[6.0]
  def change
    add_reference :tickets, :event, index: true, foreign_key: true
  end
end
