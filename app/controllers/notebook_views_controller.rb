require './app/controllers/base_controller'
require './app/models/notebook'
require './app/models/note'
require './app/models/user'

class NotebookViewsController < BaseController

  get '/all' do
    @all_notebooks = @current_user.notebooks.order(id: :asc)
    erb :all_notebooks, layout: :default_layout
  end

  get '/new' do
    erb :new_notebook, layout: :default_layout
  end

  get '/:notebook_id' do
    @notebook = Notebook.find(params[:notebook_id])
    erb :notebook, layout: :default_layout
  end

  post '/new' do
   param :title, String
   Notebook.create!(title: params[:title], user_id: @current_user.id)

   @all_notebooks = Notebook.all
   redirect to('/all')
  end

  post '/:notebook_id' do
    param :title, String

    @notebook = Notebook.find(params[:notebook_id])
    @notebook.title = params[:title] if params[:title].present?
    @notebook.save!

    redirect to ("/#{params[:notebook_id]}")
  end

  post '/:notebook_id/delete' do
    @notebook = Notebook.find(params[:notebook_id])
    @notebook.delete
    redirect to ('/all')
  end

end
