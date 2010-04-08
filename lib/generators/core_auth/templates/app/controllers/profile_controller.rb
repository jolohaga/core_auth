class ProfileController < ApplicationController
  layout 'admin'
  def show
    @user = User.find(session[:user_id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  def edit
    @user = User.find(session[:user_id])
  end
  
  def update
    @user = User.find(session[:user_id])
    if acceptable_password?(params[:password]) then @user.password = params[:password]; end
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to profile_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end  
end