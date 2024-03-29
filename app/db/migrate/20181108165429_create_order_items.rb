class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :merchandise, foreign_key: true
      t.integer :quantity, default: 1

      t.timestamps
    end
  end
end
