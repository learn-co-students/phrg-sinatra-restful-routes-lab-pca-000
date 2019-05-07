class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes/new' do # creates new form
    erb :new
  end

  get '/recipes' do # contains links to each recipe's show page
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/:id' do # displays recipes attributes and contains delete link
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do # edits recipe and displays recipe's ingreds before editing via patch request
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  post '/recipes' do  # creates recipe
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  patch '/recipes/:id' do # updates recipe
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id/delete' do # deletes recipe
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end
end
