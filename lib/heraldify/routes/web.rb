module WebRoutes
    def self.included(app)
        app.get '/' do
            @title = 'Curated Content'
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
            erb :'admin/login', :layout => :'layouts/app'
        end

        app.post '/login' do
            user = Users.find { |u| u.username = params[:username] } 
            if user && test_password(params[:password], user.password_hash)
                session.clear
                session[:user_id] = user.id
                redirect '/admin/dashboard'
            else
                @title = 'Login'
                @errors = 'Failure to log in'
                erb :'admin/login', :layout => :'layouts/app'
            end
        end
    end
end
