class AddColumnsInServiceProvider < ActiveRecord::Migration
  def change
    add_column :service_providers, :code, :integer
    add_column :service_providers, :email, :string
    add_column :service_providers, :names, :string
    add_column :service_providers, :phone, :string
    add_column :service_providers, :address, :string
    remove_column :service_providers, :title
  end
end
