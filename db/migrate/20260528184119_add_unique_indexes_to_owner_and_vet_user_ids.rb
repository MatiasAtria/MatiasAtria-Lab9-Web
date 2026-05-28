class AddUniqueIndexesToOwnerAndVetUserIds < ActiveRecord::Migration[8.1]
  def change
    remove_index :owners, :user_id
    add_index :owners, :user_id, unique: true

    remove_index :vets, :user_id
    add_index :vets, :user_id, unique: true
  end
end