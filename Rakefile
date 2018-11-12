$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'rubygems'
require 'bundler'
Bundler.setup(:default)

require 'dotenv'
Dotenv.load

require 'sinatra/activerecord/rake'
require 'pry'

namespace :db do
    task :load_config do
        require 'heraldify/app'
    end
end

task :console do
    Pry.start
end
