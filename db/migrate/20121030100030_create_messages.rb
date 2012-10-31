class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :conversation_id
      t.text :body
      t.string :from

      t.timestamps
    end
  end
end
