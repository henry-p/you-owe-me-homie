class UsersDwellings < ActiveRecord::Migration
  def change
    create_table :users_households do |t|
      t.integer :user_id
      t.integer :household_id
    end
  end
end
