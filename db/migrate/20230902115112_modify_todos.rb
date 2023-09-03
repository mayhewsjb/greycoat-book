class ModifyTodos < ActiveRecord::Migration[6.0] # Or your current Rails version
  def change
    # Add title and description columns
    add_column :todos, :title, :string
    add_column :todos, :description, :text

    # Remove the task column (optional, based on your decision)
    remove_column :todos, :task, :string
  end
end
