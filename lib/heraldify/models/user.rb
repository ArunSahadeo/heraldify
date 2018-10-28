class User < ActiveRecord::Base
    attr_accessor :name, :email
    private :password
end
