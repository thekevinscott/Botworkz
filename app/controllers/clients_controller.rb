class ClientsController < ApplicationController
  before_filter :login_required

  
  # GET /clients
  # GET /clients.xml
  def index
    
    @user = User.find(session[:user_id])    
    @clients = @user.clients.all(:order => "rate DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clients }
    end
  end

  # GET /clients/1
  # GET /clients/1.xml
  def show
    @user = User.find(session[:user_id])    
    
    @client = @user.clients.find(params[:id])

    

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.xml
  def new
    @client = Client.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @user = User.find(session[:user_id])    
    
    @client = @user.clients.find(params[:id])
    
  end

  # POST /clients
  # POST /clients.xml
  def create
    
    @user = User.find(session[:user_id])
    
    @client = @user.clients.new(params[:client])

    respond_to do |format|
      if @client.save
        flash[:notice] = 'Client was successfully created.'
        format.html { redirect_to('/clients/') }
        format.xml  { render :xml => @client, :status => :created, :location => @client }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.xml
  def update
    @user = User.find(session[:user_id])    
    
    @client = @user.clients.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        flash[:notice] = 'Client was successfully updated.'
        format.html { redirect_to('/clients/') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.xml
  def destroy
    @user = User.find(session[:user_id])    
    
    @client = @user.clients.find(params[:id])
    
    @client.destroy

    respond_to do |format|
      format.html { redirect_to(clients_url) }
      format.xml  { head :ok }
    end
  end
end
