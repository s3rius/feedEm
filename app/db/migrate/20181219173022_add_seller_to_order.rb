class AddSellerToOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :seller, foreign_key: true
  end
end
