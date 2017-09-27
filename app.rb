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
  @recipe = Recipe.new({title: recipe_title})
  @recipe.save
  erb(:index)
end
