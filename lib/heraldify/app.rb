# Sinatra
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/contrib'

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
            set :article_limit, defined? (settings.article_limit) ? settings.article_limit : 10
	end
		
        include WebRoutes
        include APIRoutes

        # Include admin routes here as cannot use them in a modular fashion

        namespace '/admin' do
            helpers AdminHelpers
            before do
                #authenticate! unless request.path_info == '/admin/login'
            end
            get '/dashboard' do
                @title = 'Dashboard'
                erb :'admin/dashboard', :layout => :'layouts/app' 
            end

            get '/users' do
                @title = 'Users'
                erb :'admin/users', :layout => :'layouts/app'
            end

            post '/users/export' do
                mime_type :xml, 'application/xml' 
            end
        end
    end
end
