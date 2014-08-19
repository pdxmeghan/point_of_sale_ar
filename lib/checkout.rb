class Checkout < ActiveRecord::Base
  has_many(:carts)
  belongs_to(:cashier)
  belongs_to(:customer)
end
