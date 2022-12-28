class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string 	:domain, null: false
      t.string 	:schema, null: false
      t.string :name, default: '', null: false
      t.string :logo, default: ''
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
