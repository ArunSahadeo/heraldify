class User < ActiveRecord::Base
    has_secure_password
    has_many :user_roles, :foreign_key => 'user_id', :class_name => 'UserRole', :dependent => :destroy
    has_many :roles, through: :user_roles
    has_many :articles
end
