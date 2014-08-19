require 'pry'

class Cashier < ActiveRecord::Base
  has_many(:checkouts)

  def total_customers
    customer_total = 0
    Checkout.all.each do |checkout|
      if checkout.cashier_id == self.id
        customer_total +=1
      end
    end
    customer_total
  end
end

