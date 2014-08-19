require 'spec_helper'

describe Cashier do
  it 'will have many checkouts' do
    test_customer = Customer.create({name: "JOHN"})
    test_cashier = Cashier.create({name: "JIMBOB"})
    test_checkout1 = Checkout.create({customer_id: test_customer.id, cashier_id: test_cashier.id})
    test_checkout2 = Checkout.create({customer_id: test_customer.id, cashier_id: test_cashier.id})
    expect(test_cashier.checkouts).to eq [test_checkout1, test_checkout2]
  end

  it 'will tally customers per cashier' do
    test_customer = Customer.create({name: "JOHN"})
    test_customer_two = Customer.create({name: "JON"})
    test_cashier = Cashier.create({name: "JIMBOB"})
    test_checkout = Checkout.create({customer_id: test_customer.id, cashier_id: test_cashier.id})
    test_checkout1 = Checkout.create({customer_id: test_customer_two.id, cashier_id: test_cashier.id})
    test_product = Product.create({name: 'Dawn', price: 3.99})
    test_cart1 = Cart.create({product_id: test_product.id, quantity: 5, checkout_id: test_checkout.id})
    expect(test_cashier.total_customers).to eq 2
  end
end
