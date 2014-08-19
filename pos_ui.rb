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
    puts "Press 'p' to add a product\nPress 'x' to exit\nPress 't' to go the the checkout\nPress 'c' to add a cashier"
    user_input = gets.chomp
    if user_input == 'p'
      add_product
    elsif user_input == 'c'
      add_cashier
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
  cart = Cart.create({product_id: product.id, quantity: quantity, checkout_id: @checkout.id })
  running_cost = []
  running_cost << product.price
  # puts "Press 'a' to add another product or 'b' to pay."
  # user_input = gets.chomp
  # if user_input == 'a'
  #   checkout_products
  # elsif user_input == 'b'
  #   finish_checkout
  # else
  #   puts "Invalid Option"
  #   main_menu
  # end
end

def finish_checkout
  puts "This is your receipt:"

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

main_menu
