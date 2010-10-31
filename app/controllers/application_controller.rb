class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter do
    Exceptional.context(:user_id => current_user.id, :email => current_user.email) unless current_user.nil?
  end
end
