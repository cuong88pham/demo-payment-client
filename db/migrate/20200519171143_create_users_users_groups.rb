class CreateUsersUsersGroups < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :users_groups do |t|

    end
  end
end
