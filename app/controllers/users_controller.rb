class UsersController < ApplicationController

    get '/users/:slug' do    
        
        @user = User.find_by(slug: params[:slug])
        # binding.pry
        @user_tweets = Tweet.select { |tweet| tweet.user_id ==  @user.id}
        
        erb :'/users/show' 
    end
end
