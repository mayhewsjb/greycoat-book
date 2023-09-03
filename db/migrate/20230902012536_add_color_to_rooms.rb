class AddColorToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :color, :string
  end
end
