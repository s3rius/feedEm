class CreateSellers < ActiveRecord::Migration[5.2]
  def change
    create_table :sellers do |t|
      t.string :name
      t.integer :likes, :default => 0
      t.integer :dislikes, :default => 0
      t.string :auth_token

      t.timestamps
    end
    add_index :sellers, :auth_token, unique: true
    add_index :sellers, :name, unique: true
  end
end
