class SessionsController < ApplicationController
  def signin
    if (! params[:password].nil? && ! params[:username].nil?)
      result = User.authenticate(params[:username], params[:password])
      if (result.nil?)
        flash[:notice] = 'Username or password invalid'
        redirect_to signin_path
      else
        set_session_vars(result)
        if session[:intended_controller].nil?
          redirect_to admin_path
        else
          redirect_to :controller => session[:intended_controller], :action => session[:intended_action], :id => session[:intended_id]
        end
      end
    end
  end

  def signout
    reset_session
    redirect_to root_path
  end
  
  def self.acceptable_password?(password)
    (!password.strip.empty? && !(password.length < 8))
  end
  
  def self.default_password
    't1e2m3p4'
  end
  
  private
  def set_session_vars(result)
    session[:user_id] = result.id
    session[:name] = result.name
  end
end