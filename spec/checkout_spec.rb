require 'spec_helper'

describe Checkout do
  it 'will have many carts' do
    test_customer = Customer.create({name: "JOHN"})
    test_cashier = Cashier.create({name: "JIMBOB"})
    test_checkout = Checkout.create ({customer_id: test_customer.id, cashier_id: test_cashier.id})
    test_product = Product.create({name: 'whatever', price: 56.78})
    test_cart = Cart.create({product_id: test_product.id, quantity: 5, checkout_id: test_checkout.id})
    test_cart1 = Cart.create({product_id: test_product.id, quantity: 4, checkout_id: test_checkout.id})
    expect(test_checkout.carts).to eq [test_cart, test_cart1]
  end

  it 'will belong to cashier' do
    test_customer = Customer.create({name: "JOHN"})
    test_cashier = Cashier.create({name: "JIMBOB"})
    test_checkout = Checkout.create ({customer_id: test_customer.id, cashier_id: test_cashier.id})
    expect(test_cashier.checkouts).to eq [test_checkout]
  end

  it 'will belong to a customer' do
    test_customer = Customer.create({name: "JOHN"})
    test_cashier = Cashier.create({name: "JIMBOB"})
    test_checkout = Checkout.create ({customer_id: test_customer.id, cashier_id: test_cashier.id})
    expect(test_customer.checkouts).to eq [test_checkout]
  end
end
