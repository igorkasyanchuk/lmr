class AddRole < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
    end
    add_column :users, :role_id, :integer
    add_index :users, :role_id
    change_column :users, :identifier, :string
    add_index :users, :identifier
  end
end
