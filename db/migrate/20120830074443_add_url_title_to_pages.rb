class AddUrlTitleToPages < ActiveRecord::Migration
  def change
    add_column :pages, :url_title, :string
  end
end
