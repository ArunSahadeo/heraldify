# Require Bundle dependencies
require 'rubygems'
require 'bundler'
Bundler.setup(:default)

$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'heraldify'

run Heraldify::App
