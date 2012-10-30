class ChangePhoneColumnTypeAndAddAddressInServiceProvider < ActiveRecord::Migration
  def change
    remove_column :service_providers, :phone
    add_column :service_providers, :phone, :string
    add_column :service_providers, :address, :string 
  end
end
