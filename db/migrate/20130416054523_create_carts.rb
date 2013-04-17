class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.string :UserID
      t.string :ProductID
      t.integer :Price
      t.string :Quantity

      t.timestamps
    end
  end
end
