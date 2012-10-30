class CreatePaymentTerminalTable < ActiveRecord::Migration
  def change
    create_table :payment_terminals do |t|
      t.integer :code
      t.string :name
      t.string :address
      t.string :phone
      t.string :bank
      t.string :email
      t.string :payment_type

      t.timestamps
    end
    add_index :payment_terminals, :code
    add_index :payment_terminals, :name
  end
end
