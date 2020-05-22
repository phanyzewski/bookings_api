class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings, id: :uuid do |t|
      t.datetime :start_time
      t.integer :duration
      t.text :details
      t.references :account, null: false, foreign_key: false, type: :uuid, index: true
      t.references :vehicle, null: false, foreign_key: false, type: :uuid, index: true

      t.timestamps
    end
  end
end
