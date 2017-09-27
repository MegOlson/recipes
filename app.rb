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
  @instructions = @recipe.instructions
  @ingredients = @recipe.ingredients
  erb(:recipes)
end

post('/ingredient') do
  @recipe = Recipe.find(params['recipe_id'])
  ingredient = params['ingredient']
  @ingredient = Ingredient.new({name: ingredient})
  @ingredient.save
  @recipe.ingredients.push(@ingredient)
  @ingredients = @recipe.ingredients
  redirect "/recipes/#{@recipe.id}"
end

patch('/recipes/:id/edit/title') do
  @recipe = Recipe.find(params[:id])
  @recipe.update({title: params["recipe_title"]})
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

get('/ingredients/:id') do
  @ingredient = Ingredient.find(params[:id])
erb(:ingredient)
end


patch('/ingredients/:id/edit') do
  @ingredient = Ingredient.find(params[:id])
  @ingredient.update({name: params["ingredients"]})
  redirect "/ingredients/#{@ingredient.id}"
end
