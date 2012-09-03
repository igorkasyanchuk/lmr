class CreateUserActivities < ActiveRecord::Migration
  def change
    create_table :user_activities do |t|
      t.string :activity
      t.integer :user_id
      t.string :ip
      t.string :params
      t.datetime :created_at
    end
    add_index :user_activities, :user_id
  end
end
