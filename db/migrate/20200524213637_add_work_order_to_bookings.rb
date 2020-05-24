class AddWorkOrderToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :work_order, :jsonb
  end
end
