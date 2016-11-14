class AddNullConstraintToUserId < ActiveRecord::Migration
  def change
    change_column :notes, :user_id, :integer, null: false
  end
end
