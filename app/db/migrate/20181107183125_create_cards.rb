class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.references :customer, foreign_key: true
      t.string :number
      t.integer :cvv
      t.date :expire

      t.timestamps
    end
    add_index :cards, :number, unique: true
  end
end
