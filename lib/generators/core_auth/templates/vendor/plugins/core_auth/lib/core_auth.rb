# CoreAuth
module CoreAuth
  def self.included(klass)
    klass.before_filter(:check_authentication, :check_authorization, :except => :signin)
  end
  
  def has_right?(user)
    user.has_right_for?(self.controller_path, action_name)
  end
  
  def user
    User.find(session[:user_id])
  end
    
  def acceptable_password?(password)
    SessionsController.acceptable_password?(password)
  end
  
  def default_password
    SessionsController.default_password
  end
  
  private
  def check_authentication
    unless session[:user_id]
      redirect_to signin_url
    end
  end

  def check_authorization
    unless has_right?(user)
      flash[:notice] = "You are not authorized to do this action."
      respond_to do |format|
        format.html { redirect_to originating_path }
        format.js {
          render :update do |page|
            page[:notice].replace_html :partial => 'shared/notice'
          end
        }
      end
    end
  end
end