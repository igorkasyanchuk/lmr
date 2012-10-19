class CreateServiceProviders < ActiveRecord::Migration
  def change
    create_table :service_providers do |t|
      t.integer :service_id
      t.integer :house_id
      t.integer :responsible_person_id
      t.integer :code
      t.string :names
      t.integer :phone
      t.string  :email

      t.timestamps
    end
    add_index :service_providers, :service_id
    add_index :service_providers, :house_id
    add_index :service_providers, :responsible_person_id
  end
end
