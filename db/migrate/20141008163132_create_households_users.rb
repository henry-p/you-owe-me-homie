class CreateHouseholdsUsers < ActiveRecord::Migration
  def change
    create_table :households_users do |t|
      t.integer :user_id
      t.integer :household_id
    end
  end
end
