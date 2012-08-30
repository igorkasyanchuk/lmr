class ChangeUserDefaultValueForemState < ActiveRecord::Migration
  def up  	
    change_column :users, :forem_state, :string, :default => 'approved'
  end

  def down
  	change_column :users, :forem_state, :string, :default => 'pending_review'
  end
end
