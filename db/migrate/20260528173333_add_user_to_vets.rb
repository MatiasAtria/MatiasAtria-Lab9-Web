class AddUserToVets < ActiveRecord::Migration[8.1]
  def change
    add_column :vets, :user_id, :bigint
    add_index :vets, :user_id
    add_foreign_key :vets, :users
  end
end
