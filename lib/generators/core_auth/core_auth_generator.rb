require 'rails/generators'

class CoreAuthGenerator < Rails::Generators::Base
  def install_core_auth
    directory 'app'
    directory 'public'
    directory 'vendor'
    
    # Inject code before end of application_controller.rb.
    #
    marker = 'end'
    gsub_file 'app/controllers/application_controller.rb', /(#{Regexp.escape(marker)})/mi do |match|
      match =%q{
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
#{marker}
}
    end
    
    # Inject code at beginning of application_helper.rb.
    #
    marker = 'module ApplicationHelper'
    gsub_file 'app/helpers/application_helper.rb', /(#{Regexp.escape(marker)})/mi do |match|
      match =%q{
#{marker}
  # Start CoreAuth
  #
  def table_for(object, options = {}, &block)
    style = options[:style] || ""
    concat("<table class='table-for #{style}'>")
    yield
    concat('</table>')
  end

  def personal_area(&block)
    if session[:user_id]
      concat "<div style='position: absolute; text-align: right; width: 960px;'>"
      yield
      concat '</div>'
    end
  end

  def system_area(&block)
    if user.admin?
      yield
    end
  end

  def content_for_locations
    content_for 'system_location' do
      system_location
    end
    content_for 'admin_location' do
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
  end
  
  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end
end