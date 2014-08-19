require 'spec_helper'

describe Customer do
  it 'will have many checkouts' do
    test_customer = Customer.create({name: "JOHN"})
    test_cashier = Cashier.create({name: "JIMBOB"})
    test_checkout1 = Checkout.create({customer_id: test_customer.id, cashier_id: test_cashier.id})
    test_checkout2 = Checkout.create({customer_id: test_customer.id, cashier_id: test_cashier.id})
    expect(test_customer.checkouts).to eq [test_checkout1, test_checkout2]
  end
end
