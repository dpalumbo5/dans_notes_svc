class CreateAuthTokens < ActiveRecord::Migration
  def change
    create_table :auth_tokens do |t|
      t.integer :user_id, null: false
      t.string :token, null: false
    end

    add_foreign_key :auth_tokens, :users
  end
end
