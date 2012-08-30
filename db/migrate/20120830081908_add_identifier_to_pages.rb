class AddIdentifierToPages < ActiveRecord::Migration
  def change
    add_column :pages, :identifier, :string
  end
end
