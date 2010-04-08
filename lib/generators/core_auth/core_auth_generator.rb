require 'rails/generators'

class CoreAuthGenerator < Rails::Generators::Base
  def install_core_auth
    directory 'app'
    directory 'public'
    directory 'vendor'
  end
  
  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end
end