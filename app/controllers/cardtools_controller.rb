class CardtoolsController < ApplicationController
	before_action :authenticate_user!
	
	# Requires user to be signed in 
	def index
		@cardtools = Cardtool.all
	end

	def new
		@cardtool = Cardtool.new
	end

	def edit
	  @cardtool = Cardtool.find(params[:id])
	  authorize! :update, @cardtool
	end

    def create
    	@user = current_user
    	@cardtool = @user.cardtools.build(cardtool_params)
    	@cardtool.save

	    if @cardtool.save
	    	redirect_to cardtool_path(@cardtool)
	    else
	    	render :action => new
	    end
	    authorize! :create, @cardtool
	end

	def update
	  @cardtool = Cardtool.find(params[:id])
	 
	  if @cardtool.update(cardtool_params)
	    redirect_to :action => :show
	  else
	    render 'edit'
	  end
	end

	def show
	    @cardtool = Cardtool.find(params[:id])
	    authorize! :show, @cardtool
	end

	def survey
	    @cardtool = Cardtool.find(params[:id])
	end

	def destroy
		@cardtool = Cardtool.find_by_id(params[:id])

		if @cardtool.destroy
		    redirect_to cardtools_path
		end
		authorize! :destroy, @cardtool
	end

	private 
	def cardtool_params 
	 	args = params.require( :cardtool ).permit( :title, :description )
		args
	end

end
