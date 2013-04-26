class Order < ActiveRecord::Base
  attr_accessible :Price, :ProductID, :UserID, :Quantity
  belongs_to :Product, :foreign_key => :ProductID 
end
