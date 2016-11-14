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

class NotesController < BaseController

 get '/' do
   all_notes = Note.all
   json notes: all_notes
 end

   post '/' do
     param :comment, String, required: true
     param :category, String

     status 201
     json note: "Received comment with category #{params[:category]}"
   end

end
