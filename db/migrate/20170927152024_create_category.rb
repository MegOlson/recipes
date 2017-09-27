class CreateCategory < ActiveRecord::Migration[5.1]
  def change
    create_table(:categories) do |c|
      c.column(:tag, :string)

      c.timestamps()
    end
  end
end
