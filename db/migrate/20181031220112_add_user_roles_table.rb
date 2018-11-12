class AddUserRolesTable < ActiveRecord::Migration[5.2]
    def self.up
        create_table :user_roles do |t|
            t.integer :user_id, :null => false, :references => [:users, :id]
            t.integer :role_id, :null => false, :references => [:roles, :id]
            t.timestamps
        end
    end

    def self.down
        drop_table :user_roles
    end
end
