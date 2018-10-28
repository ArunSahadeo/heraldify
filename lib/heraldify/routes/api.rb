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

        app.get '/api/:author/articles' do
            content_type :json
            author = Author.new
        end
    end
end
