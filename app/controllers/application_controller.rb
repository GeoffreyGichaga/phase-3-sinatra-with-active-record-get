class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get '/games' do
    games = Game.all.order(:title).limit(20)
    games.to_json
  end

  get '/games/:id' do
    games = Game.find(params[:id])
  
    games.to_json(only: [:id,:title,:genre, :price], include: {
      reviews: {only: [:comment, :score], include: {
        user: {only: [:name]}
      }}
    })


  end

end
