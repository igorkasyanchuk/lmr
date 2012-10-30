class AddTypeColumnToPaymentTerminals < ActiveRecord::Migration
  def change
    add_column :payment_terminals, :type, :string
  end
end
