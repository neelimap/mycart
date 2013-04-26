class AddProductNameToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :ProductName, :string
  end
end
