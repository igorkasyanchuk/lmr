class CreatePageParts < ActiveRecord::Migration
  def change
    create_table :page_parts do |t|
      t.string :identifier
      t.text :content, :default => ""
    end
  end
end
