require 'digest/sha2'
class User < ActiveRecord::Base
  #
  # Start CoreAuth
  validates_uniqueness_of :username
  validates_presence_of :username, :name, :email
  belongs_to :role
  # End CoreAuth
  #
  
  #
  # Start non-CoreAuth
  
  # End non-CoreAuth
  #
  
  #
  # Start CoreAuth
  def password=(password)
    salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
    self.password_salt, self.password_hash = salt, Digest::SHA256.hexdigest(password + salt) 
  end
  
  def self.authenticate(username, password)
    user = User.where('username = ?' , username).first
    if user.blank? || Digest::SHA256.hexdigest(password + user.password_salt) != user.password_hash
      return nil
    else
      return user
    end
  end
    
  def has_right_for?(controller_name, action_name)
    role.has_right_for?(controller_name, action_name)
  end
  
  def admin?
    role.admin?
  end
  # End CoreAuth
  #
  
  #
  # Start non-CoreAuth

  # End non-CoreAuth
  #
end