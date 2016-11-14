class AddFkFromNotesToUsers < ActiveRecord::Migration
  def change
    add_foreign_key :notes, :users
  end
end
