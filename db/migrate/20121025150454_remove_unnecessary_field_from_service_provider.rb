class RemoveUnnecessaryFieldFromServiceProvider < ActiveRecord::Migration
  def change    
    rename_column :service_providers, :names, :name
    add_column :service_providers, :district, :string
  end
end
