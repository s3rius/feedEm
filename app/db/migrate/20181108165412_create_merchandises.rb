class CreateMerchandises < ActiveRecord::Migration[5.2]
  def change
    create_table :merchandises do |t|
      t.references :seller, foreign_key: true
      t.string :name
      t.text :description
      t.integer :price
      t.integer :cook_time

      t.timestamps
    end
  end
end
