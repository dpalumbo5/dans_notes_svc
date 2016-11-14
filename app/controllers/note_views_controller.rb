require './app/controllers/base_controller'
require './app/models/note'
require './app/models/user'
require './app/models/notebook'

class NoteViewsController < BaseController

  get '/all' do
    @all_notes = Note.all.order(id: :asc)
    erb :all_notes, layout: :default_layout
  end

  get '/new' do
    erb :new_note, layout: :default_layout
  end

  get '/:note_id' do
    @note = Note.find(params[:note_id])
    erb :note, layout: :default_layout
  end

  post '/new' do
   param :comment, String, required: true
   param :category, String
   param :user_id, Integer, required: true
   param :notebook_id, Integer, required: true

   Note.create!(
     comment:     params[:comment],
     category:    params[:category],
     user_id:     params[:user_id],
     notebook_id: params[:notebook_id]
   )

   @all_notes = Note.all
   redirect to('/all')
  end

  post '/:note_id' do
    param :comment, String
    param :category, String

    @note = Note.find(params[:note_id])
    @note.comment = params[:comment] if params[:comment].present?
    @note.category = params[:category] if params[:category].present?
    @note.save!

    redirect to ("/#{params[:note_id]}")
  end

  post '/:note_id/delete' do
    #find the note
    @note = Note.find(params[:note_id])
    #delete the note
    @note.delete
    #redirect to notes/all
    redirect to ('/all')
  end

end
