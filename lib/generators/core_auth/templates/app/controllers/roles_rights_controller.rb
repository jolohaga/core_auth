class RolesRightsController < ApplicationController
  def assign
  end
  
  def assign_right
    @role = Role.includes(:rights).find(params[:role_id])
    @role.rights << Right.find(params[:right])
    @rights = @role.rights
    respond_to do |format|
      format.html { redirect_to @role}
      format.xml  { render :xml => @role }
    end
  end

  def unassign
    @role = Role.includes(:rights).find(params[:role_id])
    @role.rights.delete(Right.find(params[:right_id]))
    @rights = @role.rights
    respond_to do |format|
      format.html { redirect_to @role }
      format.xml { render :xml => @role }
    end
  end
end