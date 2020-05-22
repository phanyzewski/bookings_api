class CreateIdentities < ActiveRecord::Migration[6.0]
  def change
    create_table :identities, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.references :account, null: false, foreign_key: false, type: :uuid, index: true

      t.timestamps
    end
  end
end
