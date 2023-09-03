class AddDescriptionToStays < ActiveRecord::Migration[7.0]
  def change
    add_column :stays, :description, :text
  end
end
