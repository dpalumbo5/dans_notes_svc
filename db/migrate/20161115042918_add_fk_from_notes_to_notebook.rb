class AddFkFromNotesToNotebook < ActiveRecord::Migration
  def change
    add_foreign_key :notes, :notebooks
  end
end
