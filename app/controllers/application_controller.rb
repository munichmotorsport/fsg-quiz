class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :get_user_active_quiztories
  before_filter :get_quiz_collection
  before_filter :get_available_users
  
  def get_user_active_quiztories
    if user_signed_in?
      @user_active_quiztories = current_user.quiztories.where(finished: false)
    else
      @user_active_quiztories = nil
    end
  end
  
  def get_quiz_collection
    @quiz_collection = Quiz.where(production_ready: true)
  end
  
  def get_available_users
    if user_signed_in?
      @available_users = User.where('last_seen > ?', 20.minutes.ago).reject{ |u| u.email == current_user.email }
    else
      @available_users = nil
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :admin
  end
end
