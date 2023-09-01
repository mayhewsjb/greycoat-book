class AddOtherRoomNameToStays < ActiveRecord::Migration[7.0]
  def change
    add_column :stays, :other_room_name, :string
  end
end
