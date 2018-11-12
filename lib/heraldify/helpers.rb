module Helpers
    def test_password(password, hash)
        BCrypt::Password.new(hash) == password
    end

    def is_authenticated?
        unless session[:user_id].nil?
            @user = User.find(session[:user_id])
            @role_ids = UserRole.where(user_id: session[:user_id]).pluck(:role_id)
            @roles = Role.where(id: [@role_ids]).pluck(:name)

            @user != nil && @roles.include?('admin') 
        else
            redirect '/login' 
        end
    end

    class App < Sinatra::Base
        helpers Helpers
    end
end
