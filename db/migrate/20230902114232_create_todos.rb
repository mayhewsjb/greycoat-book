class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.string :task
      t.references :user, null: false, foreign_key: true
      t.integer :priority, default: 1

      t.timestamps
    end
  end
end
