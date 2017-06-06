class ContentController < ApplicationController
  before_action :authenticate_user!
  before_action :trial_end

  def monthly
    redirect_to root_path, :notice => "Access denied." unless current_user.monthly?
  end

  def yearly
    redirect_to root_path, :notice => "Access denied." unless current_user.yearly?
  end

end
