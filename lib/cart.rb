class Cart < ActiveRecord::Base
  belongs_to(:product)
  belongs_to(:checkout)
end
