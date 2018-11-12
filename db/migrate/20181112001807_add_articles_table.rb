class AddArticlesTable < ActiveRecord::Migration[5.2]
    def self.up
        create_table :articles do |t|
            t.string :slug
            t.string :post_title
            t.text   :post_content  
            t.text   :featured_image
        end
    end

    def self.down
        drop_table :articles
    end
end
