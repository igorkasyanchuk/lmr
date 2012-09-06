class RenameConsumersColumns < ActiveRecord::Migration
  def change
    change_table :consumers do |t|
      t.rename :area, :calc_area
      t.rename :number_brsdn, :numbrsdn
      t.rename :number_bmgst, :numbmgst
      t.rename :leter, :letter
    end
  end
end
