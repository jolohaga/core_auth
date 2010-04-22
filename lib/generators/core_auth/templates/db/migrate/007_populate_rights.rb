class PopulateRights < ActiveRecord::Migration
  def self.up
    Right.controllers_and_actions.each_pair do |controller, actions|
      actions.each do |action|
        Right.create(:name => Right.right_name(controller,action),
                     :controller => controller,
                     :action => action,
                     :authorization_type => Right::CORE)
      end
    end
  end

  def self.down
    Right.find(:all).each do |right|
      right.destroy
    end
  end
end