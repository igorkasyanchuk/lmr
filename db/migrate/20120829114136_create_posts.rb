class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts, :force => true do |t|
      t.integer  :post_category_id
      t.string   :title
      t.text     :description
      t.text     :content
      t.boolean  :published, :default => false
      t.string   :posted_by
      t.datetime :created_at
      t.string   :preview_file_name
      t.string   :preview_content_type
      t.integer  :preview_file_size
      t.datetime :preview_updated_at
    end

    add_index :posts, :post_category_id
  end

  def down
    remove_index :posts, :post_category_id
    drop_table :posts
  end
end
