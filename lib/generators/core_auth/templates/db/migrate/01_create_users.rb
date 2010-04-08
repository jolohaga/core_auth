class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :username
      t.boolean :active, :default => true
      t.string :password_salt
      t.string :password_hash
      t.integer :role_id
      t.timestamps
    end
    add_index :users, :role_id
  end

  def self.down
    drop_table :users
  end
end