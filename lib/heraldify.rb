# Require Bundle dependencies
require 'rubygems'
require 'bundler'
Bundler.setup(:default)

require 'dotenv'
Dotenv.load

# Helper modules

require 'date'
require 'json'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'sinatra/config_file'
require 'sinatra/namespace'

# App modules

require 'heraldify/app'
