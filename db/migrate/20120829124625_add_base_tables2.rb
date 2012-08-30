class AddBaseTables2 < ActiveRecord::Migration

  def change

    create_table :consumers do |t|
      t.string :description
      t.boolean :deleted
      t.integer :house_id
      t.string :flat
      t.string :entrance
      t.integer :floor
      t.float :area
      t.float :heat_area
      t.integer :number_brsdn
      t.integer :number_bmgst
      t.integer :leter
    end

    add_index :consumers, :house_id

  end

end
