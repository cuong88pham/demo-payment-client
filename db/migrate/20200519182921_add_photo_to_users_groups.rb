class AddPhotoToUsersGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :users_groups, :photo, :string
  end
end
