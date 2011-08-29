class DvdsController < ApplicationController
  # GET /dvds
  # GET /dvds.xml
  def index
    @dvds = Dvd.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @dvds }
    end
  end

  # GET /dvds/1
  # GET /dvds/1.xml
  def show
    @dvd = Dvd.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dvd }
    end
  end

  # GET /dvds/new
  # GET /dvds/new.xml
  def new
    @dvd = Dvd.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @dvd }
    end
  end

  # GET /dvds/1/edit
  def edit
	@dvd = Dvd.find(params[:id])
  end

  # POST /dvds
  # POST /dvds.xml
  def create
    @dvd = Dvd.new(params[:dvd])
	@dvd.userid = ""
	@dvd.verliehen = 0
    respond_to do |format|
      if @dvd.save
		
        format.html { redirect_to(@dvd, :notice => 'Dvd erfolgreich erstellt.') }
        format.xml  { render :xml => @dvd, :status => :created, :location => @dvd }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dvd.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /dvds/1
  # PUT /dvds/1.xml
  def update
    @dvd = Dvd.find(params[:id])
	@dvdusers = @dvd.userid.split(', ')
	@x = 0
	
	while @x < @dvdusers.size
		if @dvdusers[@x] == current_user.id.to_s
			alreadylent = true
		end
		@x = @x + 1
	end
	if user_signed_in?
		if alreadylent != true
			@dvd.verliehen = @dvd.verliehen + 1
			if @dvd.userid == ""
				@dvd.userid = "#{current_user.id}"
			else
				@dvd.userid = "#{@dvd.userid}, #{current_user.id}"
			end
			respond_to do |format|
				if @dvd.update_attributes(params[:dvd])
					format.html { redirect_to(@dvd, :notice => 'Dvd wurde erfolgreich ausgeliehen.') }
					format.xml  { head :ok }
				else
					format.html { render :action => "edit" }
					format.xml  { render :xml => @dvd.errors, :status => :unprocessable_entity }
				end
			end
		else
#			@x = 0
#			@dvd.userid = ""
#			@dvd.verliehen = @dvd.verliehen - 1
#			while @x < @dvdusers.size
#				if current_user.id.to_s == @dvdusers[@x]
		#			@dvdusers.delete(@x)
		#		elsif @dvd.userid = ""
		#			@dvd.userid = "#{@dvdusers[@x]}"
		#		else
		#			@dvd.userid = "#{@dvd.userid}, #{@dvdusers[@x]}"
		#		end
		#		@x = @x + 1
		#	end
			respond_to do |format|
			if @dvd.update_attributes(params[:dvd])
				format.html { redirect_to(@dvd, :notice => 'DVD wurde schon von ihnen ausgeliehen') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @dvd.errors, :status => :unprocessable_entity }
			end
			end
		end
	else
		respond_to do |format|
		if @dvd.update_attributes(params[:dvd])
			format.html { redirect_to(@dvd, :notice => 'Log In notwendig, um DVDs auszuleihen!') }
			format.xml  { head :ok }
		else
			format.html { render :action => "edit" }
			format.xml  { render :xml => @dvd.errors, :status => :unprocessable_entity }
		end
		end
	end

    
  end

  # DELETE /dvds/1
  # DELETE /dvds/1.xml
  def destroy
    @dvd = Dvd.find(params[:id])
    @dvd.destroy

    respond_to do |format|
      format.html { redirect_to(dvds_url) }
      format.xml  { head :ok }
    end
  end
end
