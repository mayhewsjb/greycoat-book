class RemoveOtherRoomNameFromStays < ActiveRecord::Migration[7.0]
  def change
    remove_column :stays, :other_room_name, :string
  end
end
