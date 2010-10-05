class ProjectsController < ApplicationController
  before_filter :login_required

  # GET /projects
  # GET /projects.xml
  
  def archive
    
    @user = User.find(session[:user_id])    

    @project = @user.projects.find_by_url(params[:id])
    @project.archive = true
    
    if @project.save
      
      #flash[:notice] = 'Project was successfully archived.'
      respond_to do |format|
      
        format.html { redirect_to('/') }
      end
    end
  end
  
  def unarchive
    
    @user = User.find(session[:user_id])    

    @project = @user.projects.find_by_url(params[:id])
    @project.archive = false
    
    if @project.save
      
      #flash[:notice] = 'Project was successfully archived.'
      respond_to do |format|
      
        format.html { redirect_to('/') }
      end
    end
  end
  
  def archived
    @user = User.find(session[:user_id])    
    @projects = @user.projects.all(:conditions => [" archive IS TRUE "])
    
    respond_to do |format|
      format.html { render :template => 'projects/index' }
      format.xml  { render :xml => @projects }
    end
  end
  
  def index
    @user = User.find(session[:user_id])    
    @projects = @user.projects.all(:conditions => [" /*archive IS FALSE ||*/ archive IS NULL "])
    
    @projects.each do |p| # patch for existing live site. eventually remove
      p.url = p.id unless p.url
    end

    respond_to do |format|
      format.html
      format.xml  { render :xml => @projects }
    end
  end

  def addPanel
    @user = User.find(session[:user_id])
    @project = @user.projects.find_by_url(params[:id])
    panel = @project.panels.new({:title => params[:panel]})
    panel.save

    respond_to do |format|
      format.js  { render :json => panel }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @user = User.find(session[:user_id])    
    
    @project = @user.projects.find_by_url(params[:id])
    if @project.nil?
      @project = @user.projects.find(params[:id])
    end
    
    if @project.panels.empty?
      panel = @project.panels.new({:title => 'comments'})
      panel.save
      note = @project.notes.last
      
      new_note = panel.notes.new({:content => note.content, :rev => note.rev})
      new_note.save


    end
    


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit

    @user = User.find(session[:user_id])    

    @project = @user.projects.find_by_url(params[:id])
    if @project.nil?
      @project = @user.projects.find(params[:id])
    end
  end

  # POST /projects
  # POST /projects.xml
  def create
    @user = User.find(session[:user_id])    
    
    @client = @user.clients.find(params[:project][:client_id])
    
    @project = @client.projects.new(params[:project])
    @project.user_id = User.find(session[:user_id]).id

    respond_to do |format|
      if @project.save
        

        @project.panels.new({:title => 'comments', :project_id => self.id}).save
        
        
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to('/projects/'+@project.url) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update

    @user = User.find(session[:user_id])    

    @project = @user.projects.find(params[:id])    

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to('/projects/'+@project.url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    
    @user = User.find(session[:user_id])    

    @project = @user.projects.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
end
