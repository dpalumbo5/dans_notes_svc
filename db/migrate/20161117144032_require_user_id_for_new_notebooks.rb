class RequireUserIdForNewNotebooks < ActiveRecord::Migration
  def change
    change_column(:notebooks, :user_id, :integer, null: false)
  end
end
