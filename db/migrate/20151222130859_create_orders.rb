class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :count
      t.decimal :price, precision: 7, scale: 2
      t.string :state

      t.timestamps null: false
    end
    add_index :orders, :user_id
    add_index :orders, :product_id
  end
end
