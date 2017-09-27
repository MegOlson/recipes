class CreateIngredientsRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table(:ingredients_recipes) do |i|
      i.column(:ingredient_id, :integer)
      i.column(:recipe_id, :integer)

      i.timestamps()
    end
  end
end
