class User < ActiveRecord::Base
  attr_accessible :City, :FirstName, :LastName, :Password, :ShippingAddress, :State, :Zip
  validates_presence_of :FirstName, :message => "First name must be provided"
  has_many :products
end
