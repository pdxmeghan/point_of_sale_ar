class ChangeCartTable < ActiveRecord::Migration
  def change
    rename_column :transaction_id, :checkout_id
  end
end
