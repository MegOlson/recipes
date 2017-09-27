class ChangeJointTable < ActiveRecord::Migration[5.1]
  def change
    rename_table(:category_recipes, :categories_recipes)
  end
end
