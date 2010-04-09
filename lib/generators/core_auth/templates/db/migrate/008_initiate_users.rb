class InitiateUsers < ActiveRecord::Migration
  def self.up
    u = User.new(:name => 'Administrator', :username => 'admin', :email => 'change me')
    u.password = 'secret'
    u.role = Role.find_by_name(Role::SYSTEM)
    u.save
  end

  def self.down
    User.find_by_name("Administrator").destroy
  end
end