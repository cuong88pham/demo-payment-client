class CreateJoinTableMangersUsersGroups < ActiveRecord::Migration[5.2]
  def change
    create_join_table :managers, :users_groups do |t|

    end
  end
end
