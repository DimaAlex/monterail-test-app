class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.integer :status, default: 0, null: false
      t.datetime :paid_at
      t.references :sector, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
