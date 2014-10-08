class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.integer :household_id
      t.decimal :amount, precision: 8, scale: 2
      t.boolean :confirmed, default: false
      t.boolean :is_bill, default: false

      t.timestamps
    end
  end
end
