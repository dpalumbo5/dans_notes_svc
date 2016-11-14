require 'sinatra'
require 'sinatra/param'
require 'sinatra/reloader'
require 'json'
require 'rack/parser'
require 'sinatra/json'
require 'active_record'
require './app/models/task'

class TasksController < BaseController

 get '/api/tasks' do
   all_tasks = Task.all
   json tasks: all_tasks
 end

   post '/api/tasks' do
     param :description, String, required: true
     param :completed, Boolean, required: true
     param :due_at, DateTime

     status 201
     json note: "Received comment with category #{params[:category]}"
   end

end
