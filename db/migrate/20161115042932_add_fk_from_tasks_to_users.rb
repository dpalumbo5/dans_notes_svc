class AddFkFromTasksToUsers < ActiveRecord::Migration
  def change
    add_column :tasks, :user_id, :integer
    add_foreign_key :tasks, :users
  end
end
