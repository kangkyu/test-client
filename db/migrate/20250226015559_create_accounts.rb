class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.string :lightspark_id, null: false
      t.string :account_name
      t.datetime :account_created_at
      t.datetime :account_updated_at

      t.timestamps
    end
    add_index :accounts, :lightspark_id, unique: true
  end
end
