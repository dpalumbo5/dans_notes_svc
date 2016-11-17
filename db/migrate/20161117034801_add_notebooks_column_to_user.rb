class AddNotebooksColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :notebook_id, :integer
  end
end
