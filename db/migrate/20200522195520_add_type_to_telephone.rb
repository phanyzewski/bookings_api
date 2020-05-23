class AddTypeToTelephone < ActiveRecord::Migration[6.0]
  def change
    add_column :telephones, :phone_type, :telephone_type
  end
end
