require("bundler/setup")
Bundler.require(:default)
require 'pry'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @recipes = Recipe.all
  erb(:index)
end

post '/recipe' do
  @recipes = Recipe.all
  recipe_title = params["recipe_title"]
  instructions = params["instructions"]
  @recipe = Recipe.new({title: recipe_title, instructions: instructions})
  @recipe.save
  erb(:index)
end

get '/recipes/:id' do
  @recipe = Recipe.find(params[:id])
  @ingredients = @recipe.ingredients
  @instructions = @recipe.instructions
  erb(:recipes)
end

post('/ingredient') do
  @recipe = Recipe.find(params['recipe_id'].to_i)
  ingredient = params['ingredient']
  @recipe.ingredients.create({ingredients: ingredient})
  @ingredients = @recipe.ingredients
  redirect "/recipes/#{@recipe.id}"
end

patch('/recipes/:id/edit/title') do
  @recipe = Recipe.find(params[:id])
  @recipe.update({title: params["recipe_title"]})
  redirect "/recipes/#{@recipe.id}"
end

patch('/recipes/:id/edit/ingredients') do
  @recipe = Recipe.find(params[:id])
  @recipe.update({ingredients: params["ingredients"]})
  redirect "/recipes/#{@recipe.id}"
end

patch('/recipes/:id/edit/instructions') do
  @recipe = Recipe.find(params[:id])
  @recipe.update({instructions: params["instructions"]})
  redirect "/recipes/#{@recipe.id}"
end

delete('/recipes/:id/delete') do
  @recipe = Recipe.find(params[:id])
  @recipe.delete
  redirect "/"
end
