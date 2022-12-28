class AddStatusToUsersGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :users_groups, :status, :integer
  end
end
