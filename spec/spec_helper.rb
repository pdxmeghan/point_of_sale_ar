require 'active_record'
require 'rspec'
require 'cashier'
require 'cart'
require 'checkout'
require 'product'
require 'customer'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))['test'])

RSpec.configure do |config|
  config.after(:each) do
    Product.all.each { |product| product.destroy }
  end
end
