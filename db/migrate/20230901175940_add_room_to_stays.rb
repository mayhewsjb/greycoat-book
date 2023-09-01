class AddRoomToStays < ActiveRecord::Migration[7.0]
  def change
    add_reference :stays, :room, null: false, foreign_key: true
  end
end
