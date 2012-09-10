class ChangeUsersColumnRoleIdDefaultValue < ActiveRecord::Migration
	def up
		change_column :users, :role_id, :integer, :default => Role.find_by_name('user').id
	end
	def down
		change_column :users, :role_id, :integer, :default => false
	end
end
