require 'sinatra'
require 'sinatra/param'
require 'sinatra/reloader'
require 'json'
require 'rack/parser'
require 'sinatra/json'
require 'active_record'
require './app/models/note'
require './app/models/task'
require './app/models/user'
require './app/models/notebook'
require './app/models/auth_token'

class BaseController < Sinatra::Base
  helpers Sinatra::Param
  use Rack::Parser
  set :views, Proc.new { File.join(root, "../views") }
  public_folder = File.dirname(__FILE__).gsub('/app/controllers','') + '/public'
  set :public_folder, public_folder

  puts "public folder - #{public_folder}"

  configure :development do
    register Sinatra::Reloader
  end


  before '/api/*' do
    content_type :json
    request.body.rewind
    @request_body    = request.body.read
    @request_payload = JSON.parse(@request_body) unless @request_body.empty?
  end

  before '*' do
    return if request.path == '/auth/login'
    return if request.path == '/users/new'

    # find auth token cookie
    token = request.cookies['Auth-Token']
    # if it doesn't exist, redirect user to login
    if token.nil?
      redirect '/auth/login'
    end

    auth_token = AuthToken.where(token:token).first

    if auth_token.nil?
      redirect '/auth/login'
    end

    @current_user = auth_token.user
  end

  error 400..502 do
    json error_message: "There is an error with your request"
  end

end
