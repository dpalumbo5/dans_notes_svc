class AddFkFromNotebooksToUsers < ActiveRecord::Migration
  def change
    add_foreign_key :notebooks, :users
  end
end
