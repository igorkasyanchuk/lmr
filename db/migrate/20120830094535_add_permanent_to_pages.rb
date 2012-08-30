class AddPermanentToPages < ActiveRecord::Migration
  def change
    add_column :pages, :permanent, :boolean, :default => false
  end
end
