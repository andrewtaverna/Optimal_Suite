class SurveysController < ApplicationController
	before_filter :checkIfSurveyIsDone

	def survey
		@hashids = Hashids.new("im gonna make billions off this stuff")
		@theCurrentId = @hashids.decode(params[:id])
	    @dashboard = Dashboard.find(@theCurrentId[1])

    	@firstQuestionId = @dashboard.questions.first.id
    	render :layout => false
	end


	def checkIfSurveyIsDone
		@hashids = Hashids.new("im gonna make billions off this stuff")
		@theCurrentId = @hashids.decode(params[:id])
	    @dashboard = Dashboard.find(@theCurrentId[1])

	    @check = false

	    @dashboard.questions.each do |question|
	    	@check = question.has_attribute?(:id)
	    end

		if @check == false
			redirect_to '/'
		end
	end

end
