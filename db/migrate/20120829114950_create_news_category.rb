class CreateNewsCategory < ActiveRecord::Migration
  def up
    create_table :post_categories, :force => true do |t|
      t.string :name, :null => false
    end
  end

  def down
    drop_table :post_categories
  end
end
