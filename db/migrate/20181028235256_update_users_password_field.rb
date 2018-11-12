class UpdateUsersPasswordField < ActiveRecord::Migration[5.2]
  def change
      remove_column :users, :encrypted_password, :string 
      remove_column :users, :salt, :string 
      add_column :users, :password_digest, :string
  end
end
