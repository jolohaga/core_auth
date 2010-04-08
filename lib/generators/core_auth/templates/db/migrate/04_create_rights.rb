class CreateRights < ActiveRecord::Migration
  def self.up
    create_table :rights do |t|
      t.string :name
      t.string :controller
      t.string :action
      t.string :authorization_type
      t.timestamps
    end
    add_index :rights, :controller
    add_index :rights, :action
  end

  def self.down
    drop_table :rights
  end
end