class AddMakeModelColorToVehicle < ActiveRecord::Migration[6.0]
  def change
    add_column :vehicles, :make, :string
    add_column :vehicles, :model, :string
    add_column :vehicles, :color, :string
  end
end
