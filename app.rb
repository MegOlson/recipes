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
  ingredients = params["ingredients"]
  instructions = params["instructions"]
  @recipe = Recipe.new({title: recipe_title, ingredients: ingredients, instructions: instructions})
  @recipe.save
  erb(:index)
end

get '/recipes/:id' do
  @recipe = Recipe.find(params[:id])
  @ingredients = @recipe.ingredients
  @instructions = @recipe.instructions
  erb(:recipes)
end

patch('/recipes/:id/edit') do
  @recipe = Recipe.find(params[:id])
  @recipe.update({title: params["recipe_title"], ingredients: params["ingredients"], instructions: params["instructions"]})
  redirect "/recipes/#{@recipe.id}"
end

delete('/recipes/:id/delete') do
  @recipe = Recipe.find(params[:id])
  @recipe.delete
  redirect "/"
end
