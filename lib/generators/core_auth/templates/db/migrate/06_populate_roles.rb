class PopulateRoles < ActiveRecord::Migration
  def self.up
    Role.create(:name => Role::SYSTEM)
  end

  def self.down
    Role.find(:all).each do |role|
      role.destroy
    end
  end
end