class Product < ActiveRecord::Base
  attr_accessible :Price, :ProductDesc, :ProductID, :ProductName
end
