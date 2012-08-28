class AddDefaultRoles < ActiveRecord::Migration
  def up
    Role.create(:name => 'admin')
    Role.create(:name => 'content_manager')
    Role.create(:name => 'user')
  end

  def down
    Role.destroy_all
  end
end
