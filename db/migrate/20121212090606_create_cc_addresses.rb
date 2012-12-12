class CreateCcAddresses < ActiveRecord::Migration
  def change
    create_table :cc_addresses do |t|
      t.string :name
      t.string :email
      t.string :description

      t.timestamps
    end
  end
end
