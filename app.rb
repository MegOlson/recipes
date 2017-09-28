require("bundler/setup")
Bundler.require(:default)
require 'pry'


Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @recipes = Recipe.order('rating DESC').all
  @tags = Category.all
  erb(:index)
end

post '/recipe' do
  recipe_title = params["recipe_title"]
  instructions = params["instructions"]
  if !recipe_title.empty? && !instructions.empty?
    @recipe = Recipe.new({title: recipe_title, instructions: instructions})
    @recipe.save
  end
  @recipes = Recipe.order('rating DESC').all
  @tags = Category.all
  erb(:index)
end

post '/search' do
  ingredient = params["ingredients"]
  @ingredient = Ingredient.find_by_name(ingredient)
  @found_recipes = []
  recipes = Recipe.all
  recipes.each do |recipe|
    if recipe.ingredients.include?(@ingredient)
      @found_recipes.push(recipe)
    end
  end
  erb(:recipes_searched)
end

post '/tag' do
  tag_name = params["tag"]
  if !tag_name.empty?
    tag = Category.new({tag: tag_name})
    tag.save
  end
  @recipes = Recipe.order('rating DESC').all
  @tags = Category.all
  redirect "/"
end

get '/recipes/:id' do
  @recipe = Recipe.find(params[:id])
  @instructions = @recipe.instructions
  @ingredients = @recipe.ingredients
  @rating = @recipe.rating
  erb(:recipes)
end

post('/ingredient') do
  @recipe = Recipe.find(params['recipe_id'])
  ingredient = params['ingredient']
  new_ingredient = Ingredient.find_or_initialize_by(name: ingredient)
  if new_ingredient.id && @recipe.ingredients.include?(new_ingredient)
  else
    new_ingredient.save
    @recipe.ingredients.push(new_ingredient)
  end
  redirect "/recipes/#{@recipe.id}"
end

get '/tags/:id' do
  @tag = Category.find(params[:id])
  @recipe_list = Recipe.all
  erb(:tag)
end

post '/recipe/add/:id' do
  @tag = Category.find(params[:id])
  @recipe = Recipe.find(params["recipe_id"])
  @tag.recipes
  @recipe.categories.push(@tag)
  @recipes = @tag.recipes
  erb(:tag_recipes)
end

patch('/recipes/:id/rate') do
  @recipe = Recipe.find(params[:id])
  rating = params["rate"]
  @recipe.rating = rating
  @recipe.save
  redirect "/recipes/#{@recipe.id}"
end

patch('/tags/:id/edit') do
  @tag = Category.find(params[:id])
  @tag.update({tag: params["tag"]})
  redirect "/tags/#{@tag.id}"
end

delete('/tags/:id/delete') do
  @tag = Category.find(params[:id])
  @tag.delete
  redirect "/"
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

delete("/ingredients/:id/delete") do
  @ingredient = Ingredient.find(params[:id])
  @ingredient.delete
  redirect "/"
end
