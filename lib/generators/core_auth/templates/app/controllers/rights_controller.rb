class RightsController < ApplicationController
  layout 'admin'
  # GET /rights
  # GET /rights.xml
  def index
    @rights = Right.paginate :per_page => 10,
                             :page => params[:page],
                             :order => 'controller, action'
    @right ||= Right.new
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rights }
    end
  end

  # GET /rights/1
  # GET /rights/1.xml
  def show
    @right = Right.includes(:roles).find(params[:id])
    @roles = @right.roles
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @right }
    end
  end

  # GET /rights/new
  # GET /rights/new.xml
  def new
    @right = Right.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @right }
    end
  end

  # GET /rights/1/edit
  def edit
    @right = Right.find(params[:id])
  end

  # POST /rights
  # POST /rights.xml
  def create
    @right = Right.new(params[:right])
    respond_to do |format|
      if @right.save
        flash[:notice] = 'Right was successfully created.'
        format.html { redirect_to rights_path }
        format.xml  { render :xml => @right, :status => :created, :location => @right }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @right.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rights/1
  # PUT /rights/1.xml
  def update
    @right = Right.find(params[:id])
    respond_to do |format|
      if @right.update_attributes(params[:right])
        flash[:notice] = 'Right was successfully updated.'
        format.html { redirect_to(@right) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @right.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rights/1
  # DELETE /rights/1.xml
  def destroy
    @right = Right.find(params[:id])
    @right.destroy
    flash[:notice] = 'Right was successfully destroyed.'
    respond_to do |format|
      format.html { redirect_to(rights_url) }
      format.xml  { head :ok }
    end
  end
  
  def discover
    @rights = Right.new_controllers_and_actions
  end
  
  def assign
    unless Right.find_by_name(params[:right_name])
      right = Right.new(:name => params[:right_name],
                        :controller => params[:right_controller],
                        :action => params[:right_action],
                        :authorization_type => Right::ANCILLARY)
      right.save
    end
  end
end