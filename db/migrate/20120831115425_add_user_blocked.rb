class AddUserBlocked < ActiveRecord::Migration
  def change
    add_column :users, :blocked ,:boolean, :default => false
    User.update_all(:blocked => false)
  end
end
