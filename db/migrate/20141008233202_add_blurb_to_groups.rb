class AddBlurbToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :blurb, :string
  end
end
