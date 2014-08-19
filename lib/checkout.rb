class Checkout < ActiveRecord::Base
  has_many(:carts)
  belongs_to(:cashier)
  belongs_to(:customer)

  def receipt_total
    total = 0
    carts.all.each do |cart|
      quantity = cart.quantity
      price = cart.product.price
      total += quantity * price
    end
    total
  end
end
