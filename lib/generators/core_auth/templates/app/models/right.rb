require 'find'
class Right < ActiveRecord::Base
  has_and_belongs_to_many :roles
  before_create :set_minimum_roles
  
  validates_presence_of :name, :controller, :action, :authorization_type
  validates_uniqueness_of :name
  validates_uniqueness_of :controller, :scope => :action
  
  CORE = "Core"
  ANCILLARY = "Ancillary"
  AUTHZ_TYPES = %W[ #{CORE} #{ANCILLARY} ]
  
  def has_right_for?(controller_name, action_name)
    action == action_name && controller == controller_name
  end
  
  def set_minimum_roles
    self.roles << Role.find_by_name(Role::SYSTEM)
  end
  
  def self.controllers_and_actions
    controller_directory = "#{Rails.root}/app/controllers/"
    controller_files = []
    controllers_and_actions = {}
    Find.find(controller_directory) do |node|
      if FileTest.file?(node)
        controller_files << node.gsub("#{controller_directory}","")
        # => ["some_controller1_controller.rb", "some_module/some_controller2_controller.rb", ...]
      end
    end
    controller_files.each do |controller_file|
      if controller_file =~ /_controller/
        controller_path = controller_file.gsub("_controller.rb","")
        # => some_controller1, some_module/some_controller2, ...
        controller = controller_file.gsub(".rb","").camelize
        # => SomeController1, SomeModule::SomeController2, ...
        actions = []
        (Kernel.const_get("#{controller}").public_instance_methods - (ApplicationController.methods + Object.methods + ApplicationController.public_instance_methods - ["new"])).reject{|w| w =~ /^_/}.sort.each do |action|
          actions << action
        end
        controllers_and_actions["#{controller_path}"] = actions
      end
    end
    controllers_and_actions
  end
  
  def self.right_name(controller, action)
    action.titlecase + ' ' + controller.titlecase
  end
  
  def self.new_controllers_and_actions
    c_and_as = controllers_and_actions
    new_c_and_as = []
    c_and_as.each_pair do |controller,actions|
      actions.each do |action|
        unless Right.find_by_controller_and_action(controller,action)
          new_c_and_as << {:controller => controller, :action => action}
        end
      end
    end
    new_c_and_as
  end
  
end