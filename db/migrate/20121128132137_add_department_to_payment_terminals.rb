class AddDepartmentToPaymentTerminals < ActiveRecord::Migration
  def change
    add_column :payment_terminals, :department, :string
  end
end