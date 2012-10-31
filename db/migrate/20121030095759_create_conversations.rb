class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :user_id
      t.integer :service_provider_id
      t.string :token
      t.string :subject

      t.timestamps
    end
  end
end
