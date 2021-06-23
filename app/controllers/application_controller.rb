require './config/environment'

class ApplicationController < Sinatra::Base
  include Slug

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "super_secure_password"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect "/tweets"
    end    
    erb :'users/signup'
    
  end

  post '/signup' do
    if params.values.include?("")
      redirect '/signup'
    end

    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    @user.set_slug

    if @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    end
    erb :'/users/failure'
  end

  get '/login' do
    if !Helpers.is_logged_in?(session)
    erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password]) 
      session[:user_id] = @user.id
      redirect "/tweets"
    end
    erb :'/users/failure'
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect '/login'
    end
    
    redirect '/'
  end

  
  get '/failure' do
    erb :'/users/failure' 
  end




end
