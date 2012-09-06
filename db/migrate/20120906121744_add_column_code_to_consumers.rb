class AddColumnCodeToConsumers < ActiveRecord::Migration
  def change
    add_column :consumers, :code, :string
  end
end
