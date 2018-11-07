class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :username
      t.string :password_digest
      t.string :name
      t.string :surname

      t.timestamps
    end
    add_index :customers, :username, unique: true
  end
end
