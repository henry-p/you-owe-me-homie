class AddAddressToHouseholds < ActiveRecord::Migration
  def change
    add_column :households, :address, :string
  end
end
