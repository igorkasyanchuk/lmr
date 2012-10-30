class RemoveUnnecessaryFieldFromServiceProvider < ActiveRecord::Migration
  def change
    remove_index :service_providers, :service_id
    remove_index :service_providers, :house_id
    remove_index :service_providers, :responsible_person_id
    remove_column :service_providers, :service_id
    remove_column :service_providers, :house_id
    remove_column :service_providers, :responsible_person_id
    rename_column :service_providers, :names, :name
    add_column :service_providers, :district, :string
  end
end
