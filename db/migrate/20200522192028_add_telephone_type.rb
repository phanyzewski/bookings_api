class AddTelephoneType < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE telephone_type AS ENUM ('mobile', 'office', 'home', 'other');
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE telephone_type;
    SQL
  end
end
