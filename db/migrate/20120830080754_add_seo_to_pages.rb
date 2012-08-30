class AddSeoToPages < ActiveRecord::Migration
  def change
    add_column :pages, :seo_title, :string
    add_column :pages, :string, :string
    add_column :pages, :seo_keywords, :text
    add_column :pages, :seo_description, :text
  end
end
