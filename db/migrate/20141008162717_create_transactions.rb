class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.integer :group_id
      t.string :amount
      t.boolean :confirmed, default: false
      t.string :transaction_type

      t.timestamps
    end
  end
end
