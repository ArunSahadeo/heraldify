# helpers
require 'heraldify/helpers'

module WebRoutes
    def self.included(app)
        app.get '/' do
            @title = 'Curated Content'
            @articles = Article.first(3)
            erb :home
        end

        app.get '/articles' do
            @title = 'Blog'
            erb :articles, :layout => :'layouts/post'
        end

        app.get '/articles/:id' do
            @article = Article.find params['id']
            @title = @article.post_title
            last_modified @article.updated_at
            erb :article, :layout => :'layouts/post'
        end

        app.get '/login' do
            @title = 'Login'
            @bodyClasses = [
                'admin'
            ]

            if session[:user_id] != nil
                redirect '/admin/dashboard'
            else 
                erb :'admin/login', :layout => :'layouts/app'
            end
        end

        app.get '/logout' do
            unless session[:user_id] != nil
                status 403
            end

            session.delete(:user_id)
            redirect '/'
        end

        app.post '/login' do
            user = User.find_by username: params[:username]
            if user && test_password(params[:password], user.password_digest)
                session.clear
                session[:user_id] = user.id
                redirect '/admin/dashboard'
            else
                errors = [
                    'You have specified an invalid username or password.'
                ]
                @errors = errors
                erb :'admin/login', :layout => :'layouts/app'
            end
        end
    end
end
