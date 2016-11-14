require './app/controllers/base_controller'
require './app/models/note'
require './app/models/user'
require './app/models/notebook'

class UserViewsController < BaseController

  get '/all' do
    @all_users = User.all.order(id: :asc)
    erb :all_users, layout: :default_layout
  end

  get '/new' do
    erb :new_user, layout: :default_layout
  end

  get '/:user_id' do
    @user = User.find(params[:user_id])
    erb :user, layout: :default_layout
  end

  post '/new' do
    param :email, String, required: true
    param :first_name, String
    param :last_name, String
    User.create!(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])

    @all_users = User.all
    redirect to('/all')
  end

  post '/:user_id' do
    param :email, String
    param :first_name, String
    param :last_name, String

    @user = User.find(params[:user_id])
    @user.first_name = params[:first_name] if params[:first_name].present?
    @user.last_name = params[:last_name] if params[:last_name].present?
    @user.email = params[:email] if params[:email].present?
    @user.save!

    redirect to ("/#{params[:user_id]}")
  end

  post '/:user_id/delete' do
    @user = User.find(params[:user_id])
    @user.delete
    redirect to ('/all')
  end
end
