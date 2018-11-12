class Role < ActiveRecord::Base
    has_many :user_roles, :foreign_key => 'role_id', :class_name => 'UserRole', :dependent => :destroy
    has_many :users, through: :user_roles
end
