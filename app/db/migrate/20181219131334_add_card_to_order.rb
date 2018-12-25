class AddCardToOrder < ActiveRecord::Migration[5.2]
  def change
  	change_table :orders do |t|
  		t.references :card, foreign_key: true
  	end
  end
end
