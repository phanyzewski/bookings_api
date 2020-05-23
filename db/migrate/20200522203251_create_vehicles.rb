class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles, id: :uuid do |t|
      t.string :vin
      t.integer :year
      t.references :account, null: false, foreign_key: false, type: :uuid, index: true

      t.timestamps
    end
  end
end
