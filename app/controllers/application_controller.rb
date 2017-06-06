class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  skip_before_action :check_for_lockup

  rescue_from CanCan::AccessDenied do |exception|
  	redirect_to dashboards_url, :alert => exception.message
  end

  def current_user_subscribed?
    user_signed_in? && current_user.subscribed?
  end
  helper_method :current_user_subscribed?

  def after_sign_up_path_for(resource)
    if params[:plan] == "free" or params[:plan] == ""
      root_path # as defined in config/routes.rb
    elsif params[:plan] == "monthly"
      new_subscription_path
    end
  end

  def trial_end
  end

  
end