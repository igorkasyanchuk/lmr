class CreateResponsiblePersons < ActiveRecord::Migration
  def change
    create_table :responsible_persons do |t|
      t.integer :service_provider_id
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :incumbency
      t.string :phone
      t.string :email

      t.timestamps
    end
    add_index :responsible_persons, :service_provider_id
  end
end
