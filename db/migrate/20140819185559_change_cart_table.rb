class ChangeCartTable < ActiveRecord::Migration
  def change
   rename_column :carts, :transaction_id, :checkout_id
    end
  end
