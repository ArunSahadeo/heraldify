# App
$LOAD_PATH.push File.expand_path('../../../app', __FILE__)

# Third party dependencies
require 'active_support/all'

# Sinatra
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/contrib'



# models
require 'models/user'
require 'models/user_role' 
require 'models/role'
require 'models/article'

require 'heraldify/routes/api'
require 'heraldify/routes/web'

# helpers
require 'heraldify/helpers'

module Heraldify
    class App < Sinatra::Base
        register Sinatra::ActiveRecordExtension
        register Sinatra::ConfigFile
        register Sinatra::Namespace

        config_file File.join(File.dirname(__FILE__), '../../settings.yml')

        set :sessions, true
        set :logging,  true

        configure do
	    time = Time.new
	    set :year, time.year
            set :datetime_now, time.strftime("%A, #{time.day.ordinalize} %B %Y %H:%M %p")
            set :article_limit, defined? (settings.article_limit) ? settings.article_limit : 10
	end

        helpers Helpers
		
        include WebRoutes
        include APIRoutes

        # Include admin routes here as cannot use them in a modular fashion

        namespace '/admin' do
            before do
                is_authenticated? unless request.path_info == '/login'
            end
            get '/dashboard' do
                @title = 'Dashboard'

                erb :'admin/dashboard', :layout => :'layouts/app' 
            end

            get '/users' do
                @title = 'Users'
                erb :'admin/users', :layout => :'layouts/app'
            end

            get '/article/new' do
                erb :'admin/article/new', :layout => :'layouts/app'
            end

            post '/article/new' do
                current_user = User.find(session[:user_id])
                article = Article.new 
                article.slug = params['slug']
                article.post_title = params['post_title']
                article.post_content = params['post_content']
                article.featured_image = Base64.strict_encode64(params['featured_image'])
                article.author = current_user.first_name 
                article.save!

                session[:success_message] = "Post #{article.id} has been created."
                redirect '/admin/dashboard'
            end

            post '/users/export' do
                mime_type :xml, 'application/xml' 
            end
        end
    end
end
