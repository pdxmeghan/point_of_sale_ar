require 'active_record'
require './lib/product'
require './lib/cashier'
require './lib/cart'
require './lib/checkout'
require './lib/customer'


database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def main_menu
  loop do
    puts "Press 'x' to exit\nPress 't' to go the the checkout\nPress 'e' to see how many customers a cashier has."
    user_input = gets.chomp
    if user_input == 'e'
      view_cashier
    elsif user_input == 't'
      checkout
    elsif user_input == 'x'
      puts 'Goodbye'
      exit
    else
      puts 'Not a valid option'
    end
  end
end


def checkout
  puts "Who's your cashier?"
  cashier_name = gets.chomp
  cashier = Cashier.find_or_create_by({name: cashier_name})
  puts "What is the customer's name?"
  customer_name = gets.chomp
  customer = Customer.find_or_create_by({name: customer_name})
  @checkout = Checkout.create({customer_id: customer.id, cashier_id: cashier.id})
  checkout_products
end

def checkout_products
  puts "\nWhat are you buying?"
  product_name = gets.chomp
  puts "\nHow much does it cost?"
  product_price = gets.chomp
  puts "\nHow many of these would you like to buy?"
  quantity = gets.chomp
  product = Product.find_or_create_by({name: product_name, price: product_price})
  @cart = Cart.create({product_id: product.id, quantity: quantity, checkout_id: @checkout.id })
  @running_cost = []
  @running_cost << product.price * @cart.quantity
  puts "Press 'a' to add another product or 'b' to pay."
  user_input = gets.chomp
  if user_input == 'a'
    checkout_products
  elsif user_input == 'b'
    finish_checkout
  else
    puts "Invalid Option"
    main_menu
  end
end

def finish_checkout
  puts "This is your receipt:"
  final_cost = @running_cost.inject(:+)
  @checkout.carts.each do |cart|
    puts "##{cart.quantity} - #{cart.product.name} - $#{cart.product.price}"
  end
  puts "#{@checkout.receipt_total}"
end

def add_product
  puts "\nWhat is the name of the product?"
  product_name = gets.chomp
  puts "\nWhat is the price of the product?"
  product_price = gets.chomp
  new_product = Product.create({name: product_name, price: product_price})
  puts "Thanks! Product has been added to the database."
end

def add_cashier
  puts "What is the name of the new cashier?"
  cashier_name = gets.chomp
  new_cashier = Cashier.create({name: cashier_name})
  puts "GRACIAS! Cashier has been added to the database."
end

def view_cashier
  puts "\n\n"
  Cashier.list_cashiers
  puts "What cashier do you want to see?\n\n"
  user_input = gets.chomp
  cashier = Cashier.find_by(name: user_input)
  if cashier
    puts "\nCashier has serviced #{cashier.total_customers} customers."
  else
    puts "I'm sorry, I didn't find that one"
  end
end

main_menu
