require './app/controllers/base_controller'
require './app/models/task'

class TaskViewsController < BaseController

  get '/all' do
    @all_tasks = @current_user.tasks.order(id: :asc)
    erb :all_tasks, layout: :default_layout
  end

  get '/new' do
    erb :new_task, layout: :default_layout
  end

  get '/:task_id' do
    @task = @current_user.tasks.find(params[:task_id])
    erb :task, layout: :default_layout
  end

  post '/new' do
   param :description, String, required: true
   param :completed, Boolean
   param :due_at, Date
   Task.create!(description: params[:description], completed: params[:completed], due_at: params[:due_at], user_id: @current_user.id)

   #@all_tasks = Task.all
   redirect to('/all')
  end

  post '/:task_id' do
    param :description, String, required: true
    param :completed, Boolean
    param :due_at, Date

    @task = Task.find(params[:task_id])
    task.description = params[:description] if params[:description].present?
    @task.completed = params[:completed] if params[:completed].present?
    @task.due_at = params[:due_at] if params[:due_at].present?
    @task.save!

    redirect to ("/#{params[:task_id]}")
  end

  post '/:task_id/delete' do
    #find the task
    @task = Task.find(params[:task_id])
    #delete the task
    @task.delete
    #redirect to tasks/all
    redirect to ('/all')
  end
end
