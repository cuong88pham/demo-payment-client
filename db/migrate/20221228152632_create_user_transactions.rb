class CreateUserTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_transactions do |t|
      t.integer :user_id 
      t.string :tracking_id 
      t.string :sender_address
      t.float :amount 
      t.integer :status
      t.json :payload
      t.timestamps
    end
  end
end
