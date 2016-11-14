require './config/boot'
Dir.glob('./app/{controllers}/*.rb').each { |file| require file }

map('/') { run BaseController }
map('/auth') { run LoginController }
map('/notes') { run NoteViewsController }
map('/tasks') { run TaskViewsController }
map('/api/notes') { run NotesController }
map('/users') {run UserViewsController }
map('/api/users') {run UsersController }
map('/notebooks') {run NotebookViewsController }
map('/api/notebooks') { run NotebooksController }
