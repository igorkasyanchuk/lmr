class AddDistrictColumnToPaymentTerminals < ActiveRecord::Migration
  def change
    add_column :payment_terminals, :district, :string
  end
end