class CreateEmailAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :email_addresses, uuid: :id do |t|
      t.string :email
      t.boolean :preferred
      t.references :identity, null: false, foreign_key: false, type: :uuid, index: true

      t.timestamps
    end
  end
end
