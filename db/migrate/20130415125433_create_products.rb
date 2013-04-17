class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products,{ :primary_key => :ProductID }  do |t|
      t.string :ProductID
      t.string :ProductName
      t.string :ProductDesc
      t.integer :Price

      t.timestamps
    end
  end
end


