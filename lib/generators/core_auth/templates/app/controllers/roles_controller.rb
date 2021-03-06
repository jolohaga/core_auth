class RolesController < ApplicationController
  layout 'admin', :except => [ :assign ]
  # GET /roles
  # GET /roles.xml
  def index
    @roles = Role.order('name').all
    @role ||= Role.new
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @roles }
    end
  end

  # GET /roles/1
  # GET /roles/1.xml
  def show
    @role = Role.includes(:rights).find(params[:id])
    @rights = @role.rights.order('controller,action')
    @unassigned_rights = Right.order('controller,action').all - @rights
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @role }
    end
  end

  # GET /roles/new
  # GET /roles/new.xml
  def new
    @role = Role.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @role }
    end
  end

  # GET /roles/1/edit
  def edit
    @role = Role.includes(:rights).find(params[:id])
    @rights_by_index = @role.rights.index_by(&:id)
    @all_rights_by_group = Right.order('controller, action').all.group_by(&:controller)
  end

  # POST /roles
  # POST /roles.xml
  def create
    @role = Role.new(params[:role])
    respond_to do |format|
      if @role.save
        flash[:notice] = 'Role was successfully created.'
        format.html { redirect_to roles_path }
        format.xml  { render :xml => @role, :status => :created, :location => @role }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    @role = Role.find(params[:id])
    respond_to do |format|
      if @role.update_attributes(params[:role])
        # First clear rights and then set them to params[:rights].keys
        @role.rights.delete_all
        if params[:rights]
          @role.rights << Right.find(params[:rights].keys)
        end
        flash[:notice] = 'Role was successfully updated.'
        format.html { redirect_to(@role) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    flash[:notice] = 'Role was successfully destroyed.'
    respond_to do |format|
      format.html { redirect_to(roles_url) }
      format.xml  { head :ok }
    end
  end
end