require 'sinatra'
require 'sinatra/param'
require 'sinatra/reloader'
require 'json'
require 'rack/parser'
require 'sinatra/json'
require 'active_record'
require './app/models/note'
require './app/models/user'
require './app/models/notebook'

class NotebooksController < BaseController

 get '/' do
   all_notebooks = Notebook.all
   json notebooks: all_notebooks
 end

 post '/' do
   param :title, String
   param :user_id, Integer, required: true

   status 201
   json note: "Received Notebook with User ID #{params[:user_id]}"
 end

end
