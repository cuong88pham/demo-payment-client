class CreateUsersGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :users_groups do |t|
      t.string :name
      t.string :memo

      t.timestamps
    end
  end
end
