class AddTransactionIndexes < ActiveRecord::Migration

  def change
    add_index :transactions, :from_user_id
    add_index :transactions, :to_user_id
    add_index :transactions, :group_id
  end

end
