class DashboardsController < ApplicationController
	before_action :authenticate_user!
	before_action :trial_end
	layout "backend_layout"
	
	# Requires user to be signed in 
	def index
		render :layout => 'frontend_layout'
		@dashboards = Dashboard.all
	end

	def new
		render :layout => 'frontend_layout'
		@dashboard = Dashboard.new
	end

	def edit
	  @dashboard = Dashboard.find(params[:id])
	  authorize! :update, @dashboard
	end

    def create
    	@user = current_user
    	@dashboard = @user.dashboards.build(dashboard_params)
    	@dashboard.questions.new(:text=>"This is a sample task.")
    	@dashboard.save

    	@tempId = Json.all.maximum(:id).next
		@homeNode = Json.new(:id=>@tempId,  :text=>"Home", :parent=>"#", :dashboardid=>@dashboard.id)
		@homeNode.save


	    if @dashboard.save
	    	redirect_to dashboard_path(@dashboard)
	    else
	    	render :action => new
	    end
	    authorize! :create, @dashboard
	end

	def update
	  @dashboard = Dashboard.find(params[:id])
	 
	  if @dashboard.update(dashboard_params)
	    redirect_to :action => :show
	  else
	    render 'edit'
	  end
	end

	def show
		
	    @dashboard = Dashboard.find(params[:id])


	    # find results for dashboardid
		@results = Result.where(dashboardid: params[:id])

		@participants = Participant.where(dashboardid: params[:id])

		# Instantiate Variables
		@correct = 0
		@wrong = 0

		# Loops through each question, loops through each result, checks if it applies to that question, 
		# if so, checks if correct, if not, checks next result until out of results and goes to next question
		# Kept relatively fast by calling only the results and dashboard objects relevant above by id

		@correctPerQuestion = Array.new
		@wrongPerQuestion = Array.new
		i = 0

		@dashboard.questions.map do |question|
			@results.each do |result|

				if question.id == result.questionid
					
					@checkBefore = @correct
					question.answers.map do |answer|
						if answer.text == result.correct_node
							@correct = @correct + 1
						end
					end
					if @checkBefore == @correct
						@wrong = @wrong +1
					end
				end
			end
			@correctPerQuestion[i] = @correct
			@wrongPerQuestion[i] = @wrong
			i = i + 1
			@correct = 0
			@wrong = 0
		end


		@total = 0
		@count = 0

		if @dashboard.questions.last != nil
			@results.where(questionid:@dashboard.questions.last.id).each do |result|
				if result.timespent != nil
					@total = @total + result.timespent
					@count = @count + 1
				end
			end
		end


		@numberOfParticipants = 0
		@participants.each do |participant|
			if @results.where(participantid:participant.id).length > 0
				@numberOfParticipants = @numberOfParticipants + 1
			end
		end




		if @count != 0
			@timeForTasks = @total / @count
		end
		if @dashboard.questions.last != nil
			@lastQuestionId = @dashboard.questions.last.id
		end

		
	    authorize! :show, @dashboard
	end

	def surveyinfo
		
	    @dashboard = Dashboard.find(params[:id])


	    # find results for dashboardid
		@results = Result.where(dashboardid: params[:id])

		@participants = Participant.where(dashboardid: params[:id])

		# Instantiate Variables
		@correct = 0
		@wrong = 0

		# Loops through each question, loops through each result, checks if it applies to that question, 
		# if so, checks if correct, if not, checks next result until out of results and goes to next question
		# Kept relatively fast by calling only the results and dashboard objects relevant above by id

		@correctPerQuestion = Array.new
		@wrongPerQuestion = Array.new
		i = 0

		@dashboard.questions.map do |question|
			@results.each do |result|

				if question.id == result.questionid
					
					@checkBefore = @correct
					question.answers.map do |answer|
						if answer.text == result.correct_node
							@correct = @correct + 1
						end
					end
					if @checkBefore == @correct
						@wrong = @wrong +1
					end
				end
			end
			@correctPerQuestion[i] = @correct
			@wrongPerQuestion[i] = @wrong
			i = i + 1
			@correct = 0
			@wrong = 0
		end


		@total = 0
		@count = 0

		if @dashboard.questions.last != nil
			@results.where(questionid:@dashboard.questions.last.id).each do |result|
				if result.timespent != nil
					@total = @total + result.timespent
					@count = @count + 1
				end
			end
		end


		@numberOfParticipants = 0
		@participants.each do |participant|
			if @results.where(participantid:participant.id).length > 0
				@numberOfParticipants = @numberOfParticipants + 1
			end
		end




		if @count != 0
			@timeForTasks = @total / @count
		end
		if @dashboard.questions.last != nil
			@lastQuestionId = @dashboard.questions.last.id
		end

		
	    authorize! :show, @dashboard
	end


	def destroy
		@dashboard = Dashboard.find_by_id(params[:id])

		if @dashboard.destroy
		    redirect_to dashboards_path
		end
		authorize! :destroy, @dashboard
	end

	def tree
		 @dashboard = Dashboard.find(params[:id])

		@results = Result.where(dashboardid: params[:id])
		authorize! :show, @dashboard
	end

	def tasks
		@dashboard = Dashboard.find(params[:id])


	    # find results for dashboardid
		@results = Result.where(dashboardid: params[:id])

		@participants = Participant.where(dashboardid: params[:id])

		# Instantiate Variables
		@correct = 0
		@wrong = 0

		# Loops through each question, loops through each result, checks if it applies to that question, 
		# if so, checks if correct, if not, checks next result until out of results and goes to next question
		# Kept relatively fast by calling only the results and dashboard objects relevant above by id

		@correctPerQuestion = Array.new
		@wrongPerQuestion = Array.new
		i = 0

		@dashboard.questions.map do |question|
			@results.each do |result|

				if question.id == result.questionid
					
					@checkBefore = @correct
					question.answers.map do |answer|
						if answer.text == result.correct_node
							@correct = @correct + 1
						end
					end
					if @checkBefore == @correct
						@wrong = @wrong +1
					end
				end
			end
			@correctPerQuestion[i] = @correct
			@wrongPerQuestion[i] = @wrong
			i = i + 1
			@correct = 0
			@wrong = 0
		end


		@total = 0
		@count = 0

		if @dashboard.questions.last != nil
			@results.where(questionid:@dashboard.questions.last.id).each do |result|
				if result.timespent != nil
					@total = @total + result.timespent
					@count = @count + 1
				end
			end
		end


		@numberOfParticipants = 0
		@participants.each do |participant|
			if @results.where(participantid:participant.id).length > 0
				@numberOfParticipants = @numberOfParticipants + 1
			end
		end




		if @count != 0
			@timeForTasks = @total / @count
		end
		if @dashboard.questions.last != nil
			@lastQuestionId = @dashboard.questions.last.id
		end

		
	    authorize! :show, @dashboard
	end

	def overview
		@dashboard = Dashboard.find(params[:id])


	    # find results for dashboardid
		@results = Result.where(dashboardid: params[:id])

		@participants = Participant.where(dashboardid: params[:id])

		# Instantiate Variables
		@correct = 0
		@wrong = 0

		# Loops through each question, loops through each result, checks if it applies to that question, 
		# if so, checks if correct, if not, checks next result until out of results and goes to next question
		# Kept relatively fast by calling only the results and dashboard objects relevant above by id

		@correctPerQuestion = Array.new
		@wrongPerQuestion = Array.new
		i = 0

		@dashboard.questions.map do |question|
			@results.each do |result|

				if question.id == result.questionid
					
					@checkBefore = @correct
					question.answers.map do |answer|
						if answer.text == result.correct_node
							@correct = @correct + 1
						end
					end
					if @checkBefore == @correct
						@wrong = @wrong +1
					end
				end
			end
			@correctPerQuestion[i] = @correct
			@wrongPerQuestion[i] = @wrong
			i = i + 1
			@correct = 0
			@wrong = 0
		end


		@total = 0
		@count = 0

		if @dashboard.questions.last != nil
			@results.where(questionid:@dashboard.questions.last.id).each do |result|
				if result.timespent != nil
					@total = @total + result.timespent
					@count = @count + 1
				end
			end
		end


		@numberOfParticipants = 0
		@participants.each do |participant|
			if @results.where(participantid:participant.id).length > 0
				@numberOfParticipants = @numberOfParticipants + 1
			end
		end




		if @count != 0
			@timeForTasks = @total / @count
		end
		if @dashboard.questions.last != nil
			@lastQuestionId = @dashboard.questions.last.id
		end

		
	    authorize! :show, @dashboard
	end

	def taskanalysis
		@dashboard = Dashboard.find(params[:id])


	    # find results for dashboardid
		@results = Result.where(dashboardid: params[:id])

		@participants = Participant.where(dashboardid: params[:id])

		# Instantiate Variables
		@correct = 0
		@wrong = 0

		# Loops through each question, loops through each result, checks if it applies to that question, 
		# if so, checks if correct, if not, checks next result until out of results and goes to next question
		# Kept relatively fast by calling only the results and dashboard objects relevant above by id

		@correctPerQuestion = Array.new
		@wrongPerQuestion = Array.new
		i = 0

		@dashboard.questions.map do |question|
			@results.each do |result|

				if question.id == result.questionid
					
					@checkBefore = @correct
					question.answers.map do |answer|
						if answer.text == result.correct_node
							@correct = @correct + 1
						end
					end
					if @checkBefore == @correct
						@wrong = @wrong +1
					end
				end
			end
			@correctPerQuestion[i] = @correct
			@wrongPerQuestion[i] = @wrong
			i = i + 1
			@correct = 0
			@wrong = 0
		end


		@total = 0
		@count = 0

		if @dashboard.questions.last != nil
			@results.where(questionid:@dashboard.questions.last.id).each do |result|
				if result.timespent != nil
					@total = @total + result.timespent
					@count = @count + 1
				end
			end
		end


		@numberOfParticipants = 0
		@participants.each do |participant|
			if @results.where(participantid:participant.id).length > 0
				@numberOfParticipants = @numberOfParticipants + 1
			end
		end




		if @count != 0
			@timeForTasks = @total / @count
		end
		if @dashboard.questions.last != nil
			@lastQuestionId = @dashboard.questions.last.id
		end

		
	    authorize! :show, @dashboard
	end

	def participants
		@dashboard = Dashboard.find(params[:id])


	    # find results for dashboardid
		@results = Result.where(dashboardid: params[:id])

		@participants = Participant.where(dashboardid: params[:id])

		# Instantiate Variables
		@correct = 0
		@wrong = 0

		# Loops through each question, loops through each result, checks if it applies to that question, 
		# if so, checks if correct, if not, checks next result until out of results and goes to next question
		# Kept relatively fast by calling only the results and dashboard objects relevant above by id

		@correctPerQuestion = Array.new
		@wrongPerQuestion = Array.new
		i = 0

		@dashboard.questions.map do |question|
			@results.each do |result|

				if question.id == result.questionid
					
					@checkBefore = @correct
					question.answers.map do |answer|
						if answer.text == result.correct_node
							@correct = @correct + 1
						end
					end
					if @checkBefore == @correct
						@wrong = @wrong +1
					end
				end
			end
			@correctPerQuestion[i] = @correct
			@wrongPerQuestion[i] = @wrong
			i = i + 1
			@correct = 0
			@wrong = 0
		end


		@total = 0
		@count = 0

		if @dashboard.questions.last != nil
			@results.where(questionid:@dashboard.questions.last.id).each do |result|
				if result.timespent != nil
					@total = @total + result.timespent
					@count = @count + 1
				end
			end
		end


		@numberOfParticipants = 0
		@participants.each do |participant|
			if @results.where(participantid:participant.id).length > 0
				@numberOfParticipants = @numberOfParticipants + 1
			end
		end




		if @count != 0
			@timeForTasks = @total / @count
		end
		if @dashboard.questions.last != nil
			@lastQuestionId = @dashboard.questions.last.id
		end

		
	    authorize! :show, @dashboard
	end

	def result
		 @dashboard = Dashboard.find(params[:id])

		@results = Result.where(dashboardid: params[:id])
		authorize! :show, @dashboard
	end

	def resultoverview
		 @dashboard = Dashboard.find(params[:id])

		@results = Result.where(dashboardid: params[:id])
		authorize! :show, @dashboard
	end

	private 
	def dashboard_params 
	 	args = params.require(:dashboard).permit(:title, :description, {questions_attributes: [ :id, :text, :_destroy, answers_attributes: [ :id, :text, :_destroy ]] } )
		args
	end

end
