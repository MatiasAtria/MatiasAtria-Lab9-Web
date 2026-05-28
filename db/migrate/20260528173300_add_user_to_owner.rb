class AddUserToOwner < ActiveRecord::Migration[8.1]
  def change
    add_column :owners, :user_id, :bigint
    add_index :owners, :user_id
    add_foreign_key :owners, :users
  end
end
