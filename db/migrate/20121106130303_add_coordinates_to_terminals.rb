class AddCoordinatesToTerminals < ActiveRecord::Migration
  def change
    add_column :payment_terminals, :latitude,  :float 
    add_column :payment_terminals, :longitude, :float 
    add_column :payment_terminals, :gmaps, :boolean 
  end
end
