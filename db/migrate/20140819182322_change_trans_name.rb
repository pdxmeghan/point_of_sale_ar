class ChangeTransName < ActiveRecord::Migration
  def change
    rename_table :transactions, :checkouts
  end
end
