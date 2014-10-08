class CreateTransations < ActiveRecord::Migration
  def change
    create_table :transations do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.demical :amount, precision: 8, scale: 2
      t.boolean :confirmed
      t.boolean :is_bill

      t.timestamps
    end
  end
end
