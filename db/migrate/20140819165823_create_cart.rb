class CreateCart < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.column :quantity, :integer
      t.column :product_id, :integer
      t.column :transaction_id, :integer

      t.timestamps
    end
  end
end
