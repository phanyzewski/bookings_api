class CreateTelephones < ActiveRecord::Migration[6.0]
  def change
    create_table :telephones do |t|
      t.string :phone_number
      t.boolean :preferred
      t.boolean :allow_sms
      t.references :identity, null: false, foreign_key: false, type: :uuid, index: true

      t.timestamps
    end
  end
end
