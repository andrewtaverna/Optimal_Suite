class VisitorsController < ApplicationController

	def index
		render :layout => false
	end

	def finished
		render :layout => 'frontend_layout'
	end

	def letsencrypt
		render text: "#{params[:id]}.BJ6dxyNByZvTFtUGHXkkz8Wm70lfbhQUQU3bItfBpMU"
	end
end
