class RemoveUrlTitleFromPages < ActiveRecord::Migration
  def up
    remove_column :pages, :url_title
  end

  def down
    add_column :pages, :url_title, :string
  end
end
