class AddBaseTables < ActiveRecord::Migration

  def change

    create_table :houses do |t|
      t.string :description
      t.boolean :deleted
      t.integer :firm_id
      t.integer :street_id
      t.string :number_code
      t.string :letter
    end

    add_index :houses, :firm_id
    add_index :houses, :street_id

    create_table :firms do |t|
      t.string :description
      t.boolean :deleted
      t.string :full_description
      t.integer :zheo_id
      t.string :bnkcc
      t.integer :street_id
      t.boolean :zkpo
      t.string :inn
      t.string :ncert
      t.string :leg_address
      t.string :address
      t.string :phone
      t.string :leg_phone
      t.string :fax
      t.string :phone_service
    end

    add_index :firms, :zheo_id
    add_index :firms, :street_id

    create_table :streets do |t|
      t.string :name
      t.boolean :deleted
    end

    create_table :services do |t|
      t.string :description
      t.boolean :deleted
      t.integer :element
      t.string :uom
      t.string :label
    end

    create_table :contractors do |t|
      t.string :description
      t.boolean :deleted
      t.string :full_description
      t.string :zkpo
      t.string :inn
      t.string :ncert
      t.string :leg_address
      t.string :address
      t.string :phone
      t.string :bnkcc
    end

    create_table :districts do |t|
      t.string :name
      t.boolean :deleted
    end

  end

end
