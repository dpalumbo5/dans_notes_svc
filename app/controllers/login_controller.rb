require './app/controllers/base_controller'
require './app/models/user'
require './app/models/auth_token'

class LoginController < BaseController

  post '/login' do
    param :email, String, required: true, blank: false
    param :password, String, required: true, blank: false

    # verify email and password are correct
    ## find user by email
    user = User.find_by(email: params[:email])
    raise ActiveRecord::RecordNotFound if user.nil?

    ## confirm password matches
    #password they type has to be the user.password
    if params[:password] != user.password
      puts "password is incorrect"
      redirect to '/login'
    end
    # create auth token
    token = AuthToken.generate_token()

    auth_token = AuthToken.create!(
      user_id: user.id,
      token: token
    )

    # set auth token as cookie in response
    response.set_cookie(
      'Auth-Token',
      value: auth_token.token,
      path: '/',
      expires: Time.now+24*60*60
    )

    redirect '/notebooks/all'
  end

  get '/logout' do
    token = @current_user.auth_token
    token.delete
    status 204
    redirect '/auth/login'
  end

  get '/login' do
    erb :login, layout: :default_layout
  end

end
