class SetDefaultRoomForStays < ActiveRecord::Migration[6.0]
  def up
    change_column_default :stays, :room, "Small Double"
  end

  def down
    change_column_default :stays, :room, nil
  end
end
