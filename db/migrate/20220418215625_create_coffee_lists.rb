class CreateCoffeeLists < ActiveRecord::Migration[6.1]
  def change
    create_table :coffee_lists do |t|
      t.string :name
      t.string :origin
      t.float :price

      t.timestamps
    end
  end
end
