class Cart < ActiveRecord::Base
  attr_accessible :Price, :ProductID, :Quantity, :UserID
  belongs_to :Product, :foreign_key => :ProductID 
end
