require 'sinatra'
require 'sinatra/param'
require 'sinatra/reloader'
require 'json'
require 'rack/parser'
require 'sinatra/json'
require 'active_record'
require './app/models/user'
require './app/models/note'
require './app/models/notebook'

class UsersController < BaseController

 get '/' do
   all_users = User.all
   json users: all_users
 end

 post '/' do
   require "pry"
   binding.pry
   param :email, String, required: true
   param :first_name, String
   param :last_name, String

   status 201
   json note: "Created new User #{params[:email]}"
 end
end
