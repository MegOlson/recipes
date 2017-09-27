class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table(:recipes) do |r|
      r.column(:ingredients, :string)
      r.column(:instructions, :string)
      r.column(:rating, :integer)

      r.timestamps()
    end
  end
end
