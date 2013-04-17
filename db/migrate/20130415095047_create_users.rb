class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :FirstName
      t.string :LastName
      t.string :Password
      t.string :ShippingAddress
      t.string :City
      t.string :State
      t.string :Zip

      t.timestamps
    end
  end
end
