class CreateSectors < ActiveRecord::Migration[6.0]
  def change
    create_table :sectors do |t|
      t.string :title
      t.integer :tickets_amount, default: 0, null: false
      t.references :event, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
