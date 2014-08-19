require 'spec_helper'

describe Product do
  it 'will have many carts' do
    test_customer = Customer.create({name: "JOHN"})
    test_cashier = Cashier.create({name: "JIMBOB"})
    test_checkout = Checkout.create({customer_id: test_customer.id, cashier_id: test_cashier.id})
    test_product = Product.create({name: 'Dawn', price: 3.99})
    test_cart1 = Cart.create({product_id: test_product.id, quantity: 5, checkout_id: test_checkout.id})
    test_cart2 = Cart.create({product_id: test_product.id, quantity: 5, checkout_id: test_checkout.id})
    expect(test_product.carts).to eq [test_cart1, test_cart2]
  end
end
