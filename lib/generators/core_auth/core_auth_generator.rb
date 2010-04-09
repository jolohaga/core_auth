require 'rails/generators'
require 'rails/generators/migration'

class CoreAuthGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  
  def install_core_auth
    directory 'app'
    directory 'public'
    directory 'vendor'
    
    # Inject code at beginning of application_controller.rb.
    #
    marker = 'class ApplicationController < ActionController::Base'
    gsub_file 'app/controllers/application_controller.rb', /(#{Regexp.escape(marker)})/mi do |match|
      match +=%q{
  # Start CoreAuth
  #
  # Roles/rights authorization applied globally.  To override, and make actions accessible
  # and views viewable by the public, put in the public controller the following:
  # skip_before_filter :check_authentication, :check_authorization
  #
  include CoreAuth
  
  helper_method :user
  before_filter :set_originating_path

  def set_originating_path
    session[:last_originating_path] = session[:originating_path]
    session[:originating_path] = request.request_uri
  end

  def originating_path
    session[:originating_path]
  end
  #
  # End CoreAuth
}
    end
    
    # Inject code at beginning of application_helper.rb.
    #
    marker = 'module ApplicationHelper'
    gsub_file 'app/helpers/application_helper.rb', /(#{Regexp.escape(marker)})/mi do |match|
      match +=%q{
  # Start CoreAuth
  #  
  def table_for(object, options = {}, &block)
    style = options[:style] || ""
    content_tag(:table, :class => 'table-for', &block)
  end

  def personal_area(&block)
    if session[:user_id]
      content_tag(:div, &block)
    end
  end

  def system_area(&block)
    if user.admin?
      content_tag(:div, &block)
    end
  end

  def content_for_locations
    content_for :system_location do
      system_location
    end
    content_for :admin_location do
      admin_location
    end
  end

  def system_location
    if ['dashboard', 'system', 'users', 'roles', 'rights', 'profile'].include? params[:controller]
      system_area do
        render :partial => 'system/system_header'
      end
    end
  end

  def admin_location
    if ['dashboard', 'administration', 'profile'].include? params[:controller]
      # Place view for controller serving as main administration area.
      # Example:
      render :partial => 'administration/admin_header'
    end
  end
  #
  # End CoreAuth
}
    end
    
    # Copy migration files.
    #
    ActiveRecord::Base.timestamped_migrations = false
    dirname = 'db/migrate'
    migration_lookup_at(dirname).each do |migration|
      migration_template "#{dirname}/#{migration}", "db/migrate"
    end
  end
  
  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end
  
  # Implement the required interface for Rails::Generators::Migration.
  # taken from http://github.com/rails/rails/blob/master/activerecord/lib/generators/active_record.rb
  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end
end