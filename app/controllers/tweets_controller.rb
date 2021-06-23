class TweetsController < ApplicationController

    get '/tweets' do
            @user = Helpers.current_user(session)
            @tweets = Tweet.all
            erb :'tweets/show'
        # else
            # redirect '/login'
        # end
    end

    get '/tweets/new' do
        if Helpers.is_logged_in?(session)
            erb :'tweets/new'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id' do
        @tweet = Tweet.find(params[:id])

        erb :'tweets/show_tweet'
    end

   

    post '/tweets' do
        # binding.pry
        if !params[:content].empty?
            user = Helpers.current_user(session)
            @tweet = Tweet.create(content: params[:content], user_id: user.id)
        else
            redirect '/tweets/new'
        end

        redirect '/tweets'
    end

    get '/tweets/:id/edit' do
        
        # binding.pry
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find(params[:id])
            erb :'tweets/edit'
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        # binding.pry
        @tweet = Tweet.find(params[:id])

        if !params[:content].empty?
            @tweet.content = params[:content]
            @tweet.save
            erb :'tweets/show_tweet'
        else
            # binding.pry
            redirect "/tweets/#{@tweet.id}/edit"
        end
    end

    delete '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        
        if @tweet.user_id == Helpers.current_user(session).id
            @tweet.delete
        end
        

        redirect '/tweets'
    end
end
