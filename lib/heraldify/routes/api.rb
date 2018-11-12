module APIRoutes
    def self.included(app)
        app.get '/api' do
            content_type :json
            status 403
            message = {
                message: "
                You cannot access the API directly. Please refer to the documentation, which can be found at #{(settings.brand['siteurl'] || 'https://heraldify.herokuapp.com') + '/api/documentation'}
                "
            }
            message[:message].to_s.strip!
            message[:message].to_s.delete!("\n")
            message.to_json
        end

        app.get '/api/user/:id/articles' do
            content_type :json

            begin
                @user = User.find(params[:id])
                @user.articles = Article.where(user_id: params[:id])

                status 200

                if @user.articles.empty?
                    message = {
                        message:  "
                        No matching articles could be found.
                        "
                    }

                    message[:message].to_s.strip!
                    message[:message].to_s.delete!("\n")
                    message.to_json
                    
                else
                    @user.articles.to_json
                end

            rescue ActiveRecord::RecordNotFound
                status 403
                message = {
                    message: "
                    You are trying to access a user who does not exist.
                    "
                }

                message[:message].to_s.strip!
                message[:message].to_s.delete!("\n")
                message.to_json
            end
        end
    end
end
