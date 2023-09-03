# db/migrate/XXXXXX_add_status_to_todos.rb

class AddStatusToTodos < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :status, :boolean, default: false
  end
end
