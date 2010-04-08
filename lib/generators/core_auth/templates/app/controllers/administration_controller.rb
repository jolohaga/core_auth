class AdministrationController < ApplicationController
  # Administration controller.  Keep password protected.
  # Use for non-system level actions.
  layout 'admin'
  
  def index
  end
  
end