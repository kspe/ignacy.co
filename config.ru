require 'rubygems'
require 'sinatra'
require './app'

set :environment, :production
set :port, 5020
disable :run, :reload

run Personal::App