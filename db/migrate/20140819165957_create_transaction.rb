class CreateTransaction < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.column :customer_id, :integer
      t.column :cashier_id, :integer

      t.timestamps
    end
  end
end
