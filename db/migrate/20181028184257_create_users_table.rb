class CreateUsersTable < ActiveRecord::Migration[5.2]

  def self.up
    create_table :users do |t|
        t.string :username
        t.string :email
        t.string :first_name
        t.string :last_name
        t.string :encrypted_password
        t.string :salt
        t.timestamps
    end
  end

  def self.down
    drop_table :users
  end

end
