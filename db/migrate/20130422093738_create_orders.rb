class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :UserID
      t.string :ProductID
      t.integer :Price
      t.string :Quantity
      t.timestamps
    end
  end
end
