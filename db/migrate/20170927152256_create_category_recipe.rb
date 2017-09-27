class CreateCategoryRecipe < ActiveRecord::Migration[5.1]
  def change
    create_table(:category_recipes) do |c|
      c.column(:recipe_id, :integer)
      c.column(:category_id, :integer)

      c.timestamps()
    end
  end
end
