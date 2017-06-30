class FiguresController < ApplicationController

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  post '/figures' do
    #binding.pry
    #binding.pry
    @figure = Figure.create(name:params[:figure][:name])
    if params[:title][:name] != ""
      @figure.titles << Title.create(params[:title])
    end
    if params[:landmark][:name] != ""
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    if !params[:figure][:title_ids].nil?
      params[:figure][:title_ids].each do |title_id|
        @figure.titles << Title.find(title_id)
      end
    end
    if !params[:figure][:landmark_ids].nil?
      params[:figure][:landmark_ids].each do |landmark_id|
        @figure.landmarks << Landmark.find(landmark_id)
      end
    end

    redirect "/figures/#{params[:id]}"
  end



  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    
    @figure = Figure.find(params[:id])
    @figure.update(name:params[:figure][:name])
    if params[:figure][:landmark] != ""
      @figure.landmarks << Landmark.create(params[:figure][:landmark])
    end
    redirect "/figures/#{params[:id]}"
  end

end
