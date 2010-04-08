class Role < ActiveRecord::Base
  has_many :users
  has_and_belongs_to_many :rights
  
  SYSTEM = "System"
  
  def has_right_for?(controller_name, action_name)
    case name
    when SYSTEM
      return true
    else
      rights.detect do |right|
        right.has_right_for?(controller_name, action_name)
      end
    end
  end
  
  def admin?
    name == SYSTEM
  end
end