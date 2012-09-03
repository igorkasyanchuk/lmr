class AddPreviewToPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :preview_file_name
    remove_column :posts, :preview_content_type
    remove_column :posts, :preview_file_size
    remove_column :posts,:preview_updated_at

    add_column :posts, :preview, :string
  end

  def down
    add_column :posts, :preview_file_name
    add_column :posts, :preview_content_type
    add_column :posts, :preview_file_size
    add_column :posts, :preview_updated_at

    remove_column :posts, :preview, :string
  end

end
