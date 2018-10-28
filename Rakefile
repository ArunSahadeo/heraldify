$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'rubygems'
require 'bundler'
Bundler.setup(:default)

require 'sinatra/activerecord/rake'

namespace :db do
    task :load_config do
        require 'heraldify/app'
    end
end
