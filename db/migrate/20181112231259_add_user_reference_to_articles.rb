class AddUserReferenceToArticles < ActiveRecord::Migration[5.2]
    def self.up
        add_reference :articles, :user, index: true
    end
    
    def self.down
        remove_reference :articles, :user, index: true
    end
end
